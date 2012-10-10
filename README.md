# Exam

The goal of exam is to provide an easy to use test suite set up for larger projects. Exam allows you to specify different suites for the different parts of the app under test, be it for engines, unbuild gems or other parts that live in your lib directory.

You can run all suites together or specify which suites to run. Exam will look for a Suitefile which it evaluates an allows your to operate on.

Exam includes:
 
- An abstract language to specify your test suite
- Fine grained control over which parts to run 
- Turning timing on, for detailed benchmarks
- Specifying required tasks, exam will stop immediately if they fail

### Example Suite File
<pre>
suite "controllers" do
	task 'rspec' do
		"rspec spec/controllers"
	end	
end
 
suite "models" do
	task 'rspec' do
		"rspec spec/models"
	end	
end

timing :on
</pre>
