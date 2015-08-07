describe('user details', function() {
	it('get user info from existing uid', function() {
		StorageCharts2.evalResponse({users:['{\"name\":\"test\",\"displayName\":\"Mister Test\"}']});
		expect(StorageCharts2.getUserFromId('test')).toBe('Mister Test');
	});
	it('get back uid from non-existing uid', function() {
		StorageCharts2.evalResponse({users:['{\"name\":\"test\",\"displayName\":\"Mister Test\"}']});
		expect(StorageCharts2.getUserFromId('test2')).toBe('test2');
	});
	it('get back uid from without users saved before', function() {
		expect(StorageCharts2.getUserFromId('test2')).toBe('test2');
	});
});