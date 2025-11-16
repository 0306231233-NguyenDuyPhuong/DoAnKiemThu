import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.testobject.TestObjectProperty
import com.kms.katalon.core.testobject.impl.HttpTextBodyContent
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
import groovy.json.JsonOutput

// Lấy dữ liệu từ Test Data Excel (Sheet cart 5 dòng)
def data = findTestData("Carts_POST") // Tên Test Data Excel của bạn

for (def i = 1; i <= data.getRowNumbers(); i++) {
    def userId = data.getValue('userId', i).toInteger()
    def productId = data.getValue('product_id', i).toInteger()
    def quantity = data.getValue('quantity', i).toInteger()

    // Tạo JSON body cho cart
    def jsonBody = [
        userId: userId,
        products: [
            [id: productId, quantity: quantity]
        ]
    ]

    // Tạo TestObject POST request
    RequestObject request = new RequestObject()
    request.setRestRequestMethod('POST')
    request.setRestUrl('https://dummyjson.com/carts/add') // endpoint thêm cart
    request.setHttpHeaderProperties([
        new TestObjectProperty('Content-Type', com.kms.katalon.core.testobject.ConditionType.EQUALS, 'application/json')
    ])
    request.setBodyContent(new HttpTextBodyContent(JsonOutput.toJson(jsonBody), 'UTF-8', 'application/json'))

    // Gửi request
    def response = WS.sendRequest(request)
    WS.verifyResponseStatusCode(response, 201) // dummyjson trả 200 khi thêm cart
    WS.comment("Response for userId ${userId}: " + response.getResponseText())
}

print("Test tạo cart thành công")
