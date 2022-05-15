component persistent="true" object="customconfig" extends="base" {

	
	property name="type" ormtype="integer";
	property name="label" ormtype="string";
	property name="values" ormtype="text";
	property name="required" ormtype="boolean";
	property name="tournament" fieldtype="many-to-one" cfc="tournament";  



	public any function isFieldInUse(){

		var data =  queryexecute('SELECT 1 FROM customdata
									where parentid = :cid', {cid: this.getid()});
		return data.recordcount;
	}
	


}