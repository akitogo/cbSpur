/*

Implements Spur.us Api for Coldbox Coldfusion
See https://spur.us/app/context/docs

You will need a spur.us account to work with this API


Written by Akitogo Team
http://www.akitogo.com

*/
component hint="" accessors="true" Singleton{

	property name="uri";
	property name="ContextApiToken";

	variables.uri='https://api.spur.us/v1/';
	variables.httpTimeout=5;
	
	/**
	 * 
	 */
	public SpurClient function init(
		string ContextApiToken
	) {
		variables.ContextApiToken=ContextApiToken;
		return this;
	}

	/**
     * returns response from context endpoint as struct
     */
    public struct function getContext(ip) {
        return sendRequest( endpoint = 'context/' & ip,apikey = variables.ContextApiToken );
    }
	
    /*  
	 * sends http request and checks for error
	 */	
	public struct function sendRequest(
		// we don't need to set arguments here
	) {	 	
	    var httpService = new http(); 
	    httpService.setMethod("GET"); 
	    httpService.setCharset("utf-8"); 
	    if(structKeyExists(arguments,'endpoint'))
	    	httpService.setUrl("#variables.uri##arguments.endpoint#");
		else
	    	httpService.setUrl("#variables.uri#");
	    httpService.settimeout(variables.httpTimeout);

		// add api key first
		httpService.addParam(type="header", name="token", value="#arguments.apiKey#");

		// then loop over all arguments and add them as url parameter
		for(var param in arguments){
			if(arguments[param] != ""  &&  arguments[param] != "endpoint" && arguments[param] != "apiKey")			
		 	   httpService.addParam(type="URL", name="#param#", value="#arguments[param]#");
		}
		var httpResponse = httpService.send().getPrefix();
		
		checkForError(httpResponse);
		
	    return deserializeJSON(httpResponse.FileContent);
	}	    

	/*  
	 * we are checking the http status code
	 * 
	 * if error, we throw and add message
	 */	
	private void function checkForError(
		httpResponse
	) {	
		switch(httpResponse.status_code){
			case '200':
				return;
			case '403':
				throw('Invalid token supplied');
				break;
			case '404':
				throw('IP address not found');
				break;
			case '429':
				throw('Out of credits');
				break;
			default:
				throw('Status code not handled');
				break;				
		}
	}
}
