import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.testobject.TestObjectProperty
import com.kms.katalon.core.testobject.impl.HttpTextBodyContent
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS

// Lấy dữ liệu từ Test Data
def data = findTestData("Users_POST")

for (def i = 1; i <= data.getRowNumbers(); i++) {
    def firstName = data.getValue('firstName', i)
    def lastName = data.getValue('lastName', i)
    def age = data.getValue('age', i)
    def email = data.getValue('email', i)
    def username = data.getValue('username', i)
    def password = data.getValue('password', i)
    def gender = data.getValue('gender', i)

    // Tạo JSON body
    def jsonBody = [
        firstName: firstName,
        lastName: lastName,
        age: age.toInteger(),
        email: email,
        username: username,
        password: password,
        gender: gender
    ]

    // Tạo TestObject POST request
    RequestObject request = new RequestObject()
    request.setRestRequestMethod('POST')
    request.setRestUrl('https://dummyjson.com/users/add')
    request.setHttpHeaderProperties([
        new TestObjectProperty('Content-Type', com.kms.katalon.core.testobject.ConditionType.EQUALS, 'application/json')
    ])
    request.setBodyContent(new HttpTextBodyContent(groovy.json.JsonOutput.toJson(jsonBody), 'UTF-8', 'application/json'))

    // Gửi request
    def response = WS.sendRequest(request)
    WS.verifyResponseStatusCode(response, 201)
    WS.comment("Response: " + response.getResponseText())
}

print("Test tạo user thành công")
