import static com.kms.katalon.core.testobject.ObjectRepository.findTestObject
import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.testobject.TestObjectProperty
import com.kms.katalon.core.testobject.impl.HttpTextBodyContent
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
import static com.kms.katalon.core.testdata.TestDataFactory.findTestData


// Lấy dữ liệu từ Test Data
def data = findTestData("Products_POST")

// Lặp từng dòng
for (def i = 1; i <= data.getRowNumbers(); i++) {
    def title = data.getValue('title', i)
    def description = data.getValue('description', i)
    def price = data.getValue('price', i)
    def discount = data.getValue('discountPercentage', i)
    def rating = data.getValue('rating', i)
    def stock = data.getValue('stock', i)
    def brand = data.getValue('brand', i)
    def category = data.getValue('category', i)
    def thumbnail = data.getValue('thumbnail', i)

    // Tạo JSON body
    def jsonBody = [
        title: title,
        description: description,
        price: price.toBigDecimal(),
        discountPercentage: discount.toBigDecimal(),
        rating: rating.toBigDecimal(),
        stock: stock.toInteger(),
        brand: brand,
        category: category,
        thumbnail: thumbnail,
    ]

    // Tạo TestObject POST request
    RequestObject request = new RequestObject()
    request.setRestRequestMethod('POST')
    request.setRestUrl('https://dummyjson.com/products/add')
    request.setHttpHeaderProperties([
        new TestObjectProperty('Content-Type', com.kms.katalon.core.testobject.ConditionType.EQUALS, 'application/json')
    ])
    request.setBodyContent(new HttpTextBodyContent(groovy.json.JsonOutput.toJson(jsonBody), 'UTF-8', 'application/json'))

    // Gửi request
    def response = WS.sendRequest(request)
    WS.verifyResponseStatusCode(response, 201)
    WS.comment("Response: " + response.getResponseText())
}

print("Test thành công");