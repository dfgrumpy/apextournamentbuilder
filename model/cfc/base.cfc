component mappedSuperClass="true" accessors="true" {

	property name="id" generator="native" ormtype="integer" fieldtype="id";
	property name="created" ormtype="timestamp";
	property name="updated" ormtype="timestamp";

	function preInsert() {
		created=now();
		updated=now();
	}

	function preUpdate(old) {
		updated=now();
	}
}