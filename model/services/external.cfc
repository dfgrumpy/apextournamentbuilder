component {
	
	public string function badwordcheck( required string data ) {


		cfhttp(method="GET", charset="utf-8", url="https://www.purgomalum.com/service/containsprofanity", result="result") {
			cfhttpparam(name="text", type="url", value="#arguments.data#");
		}
		if (result.status_code eq 200) {
			return result.filecontent;
		}

		// service failed assume good as admin can fix if vulgar
		return true;


	}
	
}
