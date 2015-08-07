describe('run chart response', function() {
	it('run passed command', function() {
		spyOn(StorageCharts2,'runEval');
		StorageCharts2.runEval
		StorageCharts2.evalResponse({chart:'console.log("test");'});
		expect(StorageCharts2.runEval).toHaveBeenCalledWith('console.log("test");');
	});	
	
	it('do not run undefined command', function() {
		spyOn(StorageCharts2,'runEval');
		StorageCharts2.runEval
		StorageCharts2.evalResponse({});
		expect(StorageCharts2.runEval).not.toHaveBeenCalled();
	});
});