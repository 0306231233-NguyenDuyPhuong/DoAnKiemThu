<?xml version="1.0" encoding="UTF-8"?>
<WebServiceRequestEntity>
   <description></description>
   <name>Post Product</name>
   <tag></tag>
   <elementGuidId>4dfdf04d-b33a-4d4d-b633-f93873feab84</elementGuidId>
   <selectorMethod>BASIC</selectorMethod>
   <smartLocatorEnabled>false</smartLocatorEnabled>
   <useRalativeImagePath>false</useRalativeImagePath>
   <autoUpdateContent>false</autoUpdateContent>
   <connectionTimeout>0</connectionTimeout>
   <followRedirects>true</followRedirects>
   <httpBody></httpBody>
   <httpBodyContent>{
  &quot;text&quot;: &quot;{\n  \&quot;title\&quot;: 7,\n  \&quot;description\&quot;: \&quot;Flagship Apple 2025, thiết kế mới, camera nâng cấp.\&quot;,\n  \&quot;price\&quot;: 8,\n  \&quot;discountPercentage\&quot;: 10.5,\n  \&quot;rating\&quot;: 4.9,\n  \&quot;stock\&quot;: 120,\n  \&quot;brand\&quot;: \&quot;Apple\&quot;,\n  \&quot;category\&quot;: \&quot;smartphones\&quot;,\n  \&quot;thumbnail\&quot;: \&quot;https://cdn.dummyjson.com/product-images/iphone-15-pro-max/thumbnail.jpg\&quot;,\n  \&quot;images\&quot;: [\n    \&quot;https://cdn.dummyjson.com/product-images/iphone-15-pro-max/1.jpg\&quot;,\n    \&quot;https://cdn.dummyjson.com/product-images/iphone-15-pro-max/2.jpg\&quot;,\n    \&quot;https://cdn.dummyjson.com/product-images/iphone-15-pro-max/3.jpg\&quot;\n  ]\n}\n&quot;,
  &quot;contentType&quot;: &quot;application/json&quot;,
  &quot;charset&quot;: &quot;UTF-8&quot;
}</httpBodyContent>
   <httpBodyType>text</httpBodyType>
   <httpHeaderProperties>
      <isSelected>true</isSelected>
      <matchCondition>equals</matchCondition>
      <name>Content-Type</name>
      <type>Main</type>
      <value>application/json</value>
      <webElementGuid>eb2af994-5090-4e4c-b3cf-4cf63d11b40d</webElementGuid>
   </httpHeaderProperties>
   <httpHeaderProperties>
      <isSelected>true</isSelected>
      <matchCondition>equals</matchCondition>
      <name>Accept</name>
      <type>Main</type>
      <value>application/json</value>
      <webElementGuid>ca60d42a-8e3d-40b8-83a8-9a5cc0d7435f</webElementGuid>
   </httpHeaderProperties>
   <katalonVersion>10.3.2</katalonVersion>
   <maxResponseSize>0</maxResponseSize>
   <migratedVersion>5.4.1</migratedVersion>
   <path></path>
   <restRequestMethod>POST</restRequestMethod>
   <restUrl>https://dummyjson.com/products/add</restUrl>
   <serviceType>RESTful</serviceType>
   <soapBody></soapBody>
   <soapHeader></soapHeader>
   <soapRequestMethod></soapRequestMethod>
   <soapServiceEndpoint></soapServiceEndpoint>
   <soapServiceFunction></soapServiceFunction>
   <socketTimeout>0</socketTimeout>
   <useServiceInfoFromWsdl>true</useServiceInfoFromWsdl>
   <verificationScript>import static org.assertj.core.api.Assertions.*

import com.kms.katalon.core.testobject.RequestObject
import com.kms.katalon.core.testobject.ResponseObject
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
import com.kms.katalon.core.webservice.verification.WSResponseManager

import groovy.json.JsonSlurper
import internal.GlobalVariable as GlobalVariable

RequestObject request = WSResponseManager.getInstance().getCurrentRequest()

ResponseObject response = WSResponseManager.getInstance().getCurrentResponse()</verificationScript>
   <wsdlAddress></wsdlAddress>
</WebServiceRequestEntity>
