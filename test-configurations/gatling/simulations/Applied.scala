import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._
import io.gatling.core.session.Expression

class Applied extends Simulation {

    val userIdFeeder = Iterator.from(0).map(i => Map("userId" -> i))

    val jsfViewStateCheck = regex("""="javax.faces.ViewState" value="([^"]*)"""")
  .saveAs("viewState")

    def jsfGet(name: String, url: Expression[String]) = http(name).get(url)
    .check(jsfViewStateCheck)

    def jsfPost(name: String, url: Expression[String]) = http(name).post(url)
    .formParam("javax.faces.ViewState", "${viewState}")
    .check(jsfViewStateCheck)

    def jsfPostNoState(name: String, url: Expression[String]) = http(name).post(url)
    .check(jsfViewStateCheck)

    val httpProtocol = http 
        .baseURL("http://server:8080")
        .extraInfoExtractor(dumpSessionOnFailure)
        .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
        .acceptEncodingHeader("gzip, deflate")
        .connection("keep-alive")
        .contentTypeHeader("application/x-www-form-urlencoded")

    val scn = scenario("CreateAndApproveReport").feed(userIdFeeder).exitBlockOnFail{
        
        group("john") {
         exec(jsfGet("homepage", "/ds-expense-tracker/login.jsf"))
        .exec(jsfPost("login", "/ds-expense-tracker/login.jsf")
            .formParam("login:form", "login:form")
            .formParam("login:form:loginBtn", "Log in")
            .formParam("login:form:username", "john")
            .formParam("login:form:password", "john"))
        .exec(jsfPost("create_report", "/ds-expense-tracker/secured/home.jsf")
            .formParam("reportedByMeForm", "reportedByMeForm")
            .formParam("reportedByMeForm:createReportBtn", "Create a report"))
        .exec(jsfPost("save_report", "/ds-expense-tracker/secured/report.jsf?cid=1")
            .formParam("reportForm", "reportForm")
            .formParam("reportForm:saveBtn", "Save")
            .formParam("reportForm:reportName", "TestReport${userId}")
            .formParam("reportForm:reportDescription", "Testing Gatling"))
        .exec(jsfPost("add_expense", "/ds-expense-tracker/secured/report.jsf?cid=1")
            .formParam("expensesForm", "expensesForm")
            .formParam("expensesForm:addExpenseBtn", "Add Expense"))
        .exec(jsfPost("save_expense", "/ds-expense-tracker/secured/expense.jsf?cid=1")
            .formParam("expenseForm", "expenseForm")
            .formParam("expenseForm:saveBtn", "Save")
            .formParam("expenseForm:purpose", "5")
            .formParam("expenseForm:receipt", "")
            .formParam("expenseForm:dateInputDate", "Jan 6, 2015")
            .formParam("expenseForm:dateInputCurrentDate", "01/2015")
            .formParam("expenseForm:value", "100"))
        .exec(jsfPost("submit_report", "/ds-expense-tracker/secured/report.jsf?cid=1")
            .formParam("actionsForm", "actionsForm")
            .formParam("actionsForm:submit", "Submit"))
        .exec(jsfPost("logout", "/ds-expense-tracker/secured/home.jsf")
            .formParam("toolbarForm", "toolbarForm")
            .formParam("toolbarForm:currentUserName", "john")
            .formParam("toolbarForm:navUserLogout", "toolbarForm:navUserLogout"))
            }

        .group("anna") {
        exec(jsfPost("login", "/ds-expense-tracker/login.jsf")
            .formParam("login:form", "login:form")
            .formParam("login:form:loginBtn", "Log in")
            .formParam("login:form:username", "anna")
            .formParam("login:form:password", "anna")
            .check(regex("""<a\s*.*id="([^"]+)".*>TestReport${userId}</a>""").saveAs("reportLink")))
        .exec(jsfPost("open_report", "/ds-expense-tracker/secured/home.jsf")
            .formParam("unassignedForm", "unassignedForm")
            .formParam("${reportLink}", "${reportLink}"))
        .exec(jsfPost("assign", "/ds-expense-tracker/secured/report.jsf?cid=1")
            .formParam("actionsForm", "actionsForm")
            .formParam("actionsForm:assignToMe", "Assign to me"))
        .exec(jsfPost("add_reimb", "/ds-expense-tracker/secured/report.jsf?cid=1")
            .formParam("reimbursementsForm", "reimbursementsForm")
            .formParam("reimbursementsForm:addReimbursementBtn", "Add reimbursement"))
        .exec(jsfPost("save_reimb", "/ds-expense-tracker/secured/reimbursement.jsf?cid=1")
            .formParam("reimbursementForm", "reimbursementForm")
            .formParam("reimbursementForm:saveBtn", "Save")
            .formParam("reimbursementForm:dateInputDate", "Jan 6, 2015")
            .formParam("reimbursementForm:dateInputCurrentDate", "01/2015")
            .formParam("reimbursementForm:value", "100"))
        .exec(jsfPost("approve", "/ds-expense-tracker/secured/report.jsf?cid=1")
            .formParam("actionsForm", "actionsForm")
            .formParam("actionsForm:approve", "Approve")
            .check(regex("""<a\s*.*id="([^"]+)".*>TestReport${userId}</a>""").saveAs("reportLink")))
        .exec(jsfPost("open_report_2", "/ds-expense-tracker/secured/home.jsf")
            .formParam("assignedToMeForm", "assignedToMeForm")
            .formParam("${reportLink}", "${reportLink}"))
        .exec(jsfPost("settle", "/ds-expense-tracker/secured/report.jsf?cid=2")
            .formParam("actionsForm", "actionsForm")
            .formParam("actionsForm:settle", "Settle"))
        .exec(jsfPost("logout", "/ds-expense-tracker/secured/home.jsf")
            .formParam("toolbarForm", "toolbarForm")
            .formParam("toolbarForm:currentUserName", "anna")
            .formParam("toolbarForm:navUserLogout", "toolbarForm:navUserLogout"))
            }
    }

    setUp(scn.inject(
        atOnceUsers(5), nothingFor(20 seconds), rampUsers(200) over(300 seconds)
    )).protocols(httpProtocol)
}