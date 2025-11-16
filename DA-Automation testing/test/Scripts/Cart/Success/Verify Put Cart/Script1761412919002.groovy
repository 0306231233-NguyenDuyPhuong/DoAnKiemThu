import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.testobject.TestObjectProperty
import com.kms.katalon.core.testobject.impl.HttpTextBodyContent
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
import groovy.json.JsonOutput

// Lấy dữ liệu từ Test Data Excel
def data = findTestData("Carts_POST") // Sheet Excel của bạn

for (def i = 1; i <= data.getRowNumbers(); i++) {
    def userId = data.getValue('userId', i).toInteger()
    def productId = data.getValue('product_id', i).toInteger()
    def quantity = data.getValue('quantity', i).toInteger()

    // Tạo JSON body cho cart (cập nhật)
    def jsonBody = [
        userId: userId,
        products: [
            [id: productId, quantity: quantity]
        ]
    ]

    // Giả sử bạn đã biết cartId tương ứng với userId, ví dụ cartId = userId
    def cartId = userId

    // Tạo TestObject PUT request
    RequestObject request = new RequestObject()
    request.setRestRequestMethod('PUT')
    request.setRestUrl("https://dummyjson.com/carts/${cartId}") // endpoint PUT cart
    request.setHttpHeaderProperties([
        new TestObjectProperty('Content-Type', com.kms.katalon.core.testobject.ConditionType.EQUALS, 'application/json')
    ])
    request.setBodyContent(new HttpTextBodyContent(JsonOutput.toJson(jsonBody), 'UTF-8', 'application/json'))

    // Gửi request
    def response = WS.sendRequest(request)
    WS.verifyResponseStatusCode(response, 200) // PUT trả 200 khi cập nhật thành công
    WS.comment("Response for cartId ${cartId}: " + response.getResponseText())
}

print("Test cập nhật cart thành công")
