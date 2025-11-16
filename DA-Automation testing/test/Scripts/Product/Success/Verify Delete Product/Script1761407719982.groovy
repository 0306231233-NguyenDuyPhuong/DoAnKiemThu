import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS

// Lấy dữ liệu từ Test Data
def data = findTestData("Products_DELETE")

for (def i = 1; i <= data.getRowNumbers(); i++) {
    def id = data.getValue('id', i)

    // Tạo TestObject DELETE request
    RequestObject request = new RequestObject()
    request.setRestRequestMethod('DELETE')
    request.setRestUrl("https://dummyjson.com/products/${id}")

    // Gửi request
    def response = WS.sendRequest(request)

    // Verify status code
    WS.verifyResponseStatusCode(response, 200)

    // In ra response
    WS.comment("Response for ID ${id}: " + response.getResponseText())
}

print("Test delete thành công")
