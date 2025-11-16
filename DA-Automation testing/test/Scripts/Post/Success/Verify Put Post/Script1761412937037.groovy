import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.testobject.TestObjectProperty
import com.kms.katalon.core.testobject.impl.HttpTextBodyContent
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS

// Lấy dữ liệu từ Test Data
def data = findTestData("Posts_PUT") // Excel sheet PUT 5 dòng

for (def i = 1; i <= data.getRowNumbers(); i++) {
    def id = data.getValue('id', i)
    def title = data.getValue('title', i)
    def body = data.getValue('body', i)
    def userId = data.getValue('userId', i)

    // Tạo JSON body
    def jsonBody = [
        title: title,
        body: body,
        userId: userId.toInteger(),
    ]

    // Tạo TestObject PUT request
    RequestObject request = new RequestObject()
    request.setRestRequestMethod('PUT')
    request.setRestUrl("https://dummyjson.com/posts/${id}") // PUT theo ID
    request.setHttpHeaderProperties([
        new TestObjectProperty('Content-Type', com.kms.katalon.core.testobject.ConditionType.EQUALS, 'application/json')
    ])
    request.setBodyContent(new HttpTextBodyContent(groovy.json.JsonOutput.toJson(jsonBody), 'UTF-8', 'application/json'))

    // Gửi request
    def response = WS.sendRequest(request)
    WS.verifyResponseStatusCode(response, 200) // PUT trả 200
    WS.comment("Response for ID ${id}: " + response.getResponseText())
}
