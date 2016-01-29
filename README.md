# MQTT-Worklight-Cordova-Plugin-For-IOS
It's a sample for Mqtt in ios using Cordova /Worklight plugin

1. Open your XCODE project
2. Copy Mqtt libraries to your project
    a. libmosquitto
    b. MQTTKit
3. In your Xcode project --> Classes folder --> create these 2 files(Its given in MQTT-Worklight-Cordova-plugin-For-IOS)
    a. Create MQTTViewController.h
    b. Create MQTTViewController.m
4. main.js (Call MQTT plugin)
    a. To subscribe Mqtt

        function sub(){
            cordova.exec(subscribeMQTTSuccess,subscribeMQTTFailure,"MQTTViewController","subscribe",["YourTopic"]);
        }
        
    b. To Publish Mqtt
    
        function pub(){
            cordova.exec(publishMQTTSuccess,publishMQTTFailure,"MQTTFedPOSplugin","pubMssgAction",["YourTopic"]);
        }
        
    c. To recieve response from Plugin
    
        function subscribeMQTTSuccess(data)
        {
            alert("Success");
            //cordova.exec(disconnectMQTTSuccess,disconnectMQTTFailure,"MQTTViewController","disconnect",[]);
        }
        function subscribeMQTTFailure(data)
        {
           
           // cordova.exec(disconnectMQTTSuccess,disconnectMQTTFailure,"MQTTViewController","disconnect",[]);
        }
        function publishMQTTSuccess(data)
        {
           
        	//cordova.exec(disconnectMQTTSuccess,disconnectMQTTFailure,"MQTTViewController","disconnect",[]);
        
        }
        function publishMQTTFailure(data)
        {
        	//cordova.exec(disconnectMQTTSuccess,disconnectMQTTFailure,"MQTTViewController","disconnect",[]);
        
        }
        function disconnectMQTTSuccess(data)
        {
        }
        function disconnectMQTTFailure(data)
        {
        }
        
5. config.xml

    <feature name="MQTTViewController">
        <param name="ios-package" value="MQTTViewController" />
    </feature>
      


    
