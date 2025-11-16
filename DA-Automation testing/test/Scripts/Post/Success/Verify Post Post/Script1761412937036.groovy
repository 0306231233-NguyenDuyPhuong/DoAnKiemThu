import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.testobject.TestObjectProperty
import com.kms.katalon.core.testobject.impl.HttpTextBodyContent
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS

// Lấy dữ liệu từ Test Data
def data = findTestData("Posts_POST") 

for (def i = 1; i <= data.getRowNumbers(); i++) {
    def title = data.getValue('title', i)
    def body = data.getValue('body', i)
    def userId = data.getValue('userId', i)

    def jsonBody = [
        title: title,
        body: body,
        userId: userId.toInteger(),
    ]

    RequestObject request = new RequestObject()
    request.setRestRequestMethod('POST')
    request.setRestUrl('https://dummyjson.com/posts/add') // endpoint POST bài viết
    request.setHttpHeaderProperties([
        new TestObjectProperty('Content-Type', com.kms.katalon.core.testobject.ConditionType.EQUALS, 'application/json')
    ])
    request.setBodyContent(new HttpTextBodyContent(groovy.json.JsonOutput.toJson(jsonBody), 'UTF-8', 'application/json'))

    def response = WS.sendRequest(request)
    WS.verifyResponseStatusCode(response, 201)
    WS.comment("Response: " + response.getResponseText())
}

print("Test tạo post thành công")
