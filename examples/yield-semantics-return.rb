def inner &closure
  puts "\t\tmain -&gt; outer -&gt; inner: Calling closure &lt;call site&gt;"
  closure.call
  puts "\t\tmain -&gt; outer -&gt;  inner: Called closure &lt;/call site&gt;"
end
def outer
  puts "\tmain -&gt; outer: Invoking inner &lt;creation site&gt;"
  inner do
    puts "\t\t\tmain -&gt; outer -&gt; inner -&gt; closure: Return from closure"
    return
    puts "\t\t\tmain -&gt; outer -&gt; inner -&gt; closure: Returned from closure"
  end
  puts "\tmain -&gt; outer: Invoked outer &lt;/creation site&gt;"
end
puts "main: Invoking outer"
outer
puts "main: Invoked outer"
#=&gt; main: Invoking outer
#=&gt;   main -&gt; outer: Invoking inner &lt;creation site&gt;
#=&gt;      main -&gt; outer -&gt; inner: Calling closure &lt;call site&gt;
#=&gt;        main -&gt; outer -&gt; inner -&gt; closure: Return from closure
#=&gt; main: Invoked outer

