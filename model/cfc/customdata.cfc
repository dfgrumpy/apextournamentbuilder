component persistent="true" object="customdata" extends="base" {

	
	property name="value" ormtype="string";
	property name="parentid" ormtype="integer";
	property name="player" fieldtype="many-to-one" cfc="player";  


	public any function getConfig(){

		var data =  ormExecuteQuery('FROM customconfig
									where id = :pid order by id', {pid: this.getparentid()}, true);
		return data
	}
	


}