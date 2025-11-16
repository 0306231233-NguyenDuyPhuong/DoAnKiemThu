import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.testobject.TestObjectProperty
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS

// Lấy dữ liệu từ Test Data Excel
def data = findTestData("Carts_DELETE") // Sheet Excel của bạn

for (def i = 1; i <= data.getRowNumbers(); i++) {
    def userId = data.getValue('userId', i).toInteger()

    // Giả sử cartId = userId
    def cartId = userId

    // Tạo TestObject DELETE request
    RequestObject request = new RequestObject()
    request.setRestRequestMethod('DELETE')
    request.setRestUrl("https://dummyjson.com/carts/${cartId}") // endpoint DELETE cart
    request.setHttpHeaderProperties([
        new TestObjectProperty('Content-Type', com.kms.katalon.core.testobject.ConditionType.EQUALS, 'application/json')
    ])

    // Gửi request
    def response = WS.sendRequest(request)
    WS.verifyResponseStatusCode(response, 200) // dummyjson trả 200 khi xóa thành công
    WS.comment("Deleted cartId ${cartId}, response: " + response.getResponseText())
}

print("Test xóa cart thành công")
