CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests


# 2. Check that the student code contains the ListExample.java file

if [[ -f student-submission/ListExamples.java ]]
then 
    echo "ListExample.java file found"
else
    echo "ListExample.java file not found"
    echo "Grade: 0"
    exit
fi

# 3. Put all the relevant files into the grading area directory

cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area

# 4. Compile all the java files and check that they compiled successfully

cd grading-area
# javac -cp $CPATH TestListExamples.java ListExamples.java
javac -cp $CPATH *.java

if [[ $? -eq 0 ]]
then
    echo "Compilation successful"
else
    echo "Compilation not successful"
    echo "Grade: 0"
    exit
fi

# 5. Run the tests and report the grade based on the test results

# java -cp $CPATH:. org.junit.runner.JUnitCore TestListExamples

# if [[ $? -eq 0 ]]
# then
#     echo "All tests passed"
#     echo "Grade: 100"
# else
#     echo "Some tests failed"
#     echo "Grade: 0"
# fi


output=$(java -cp "$CPATH:." org.junit.runner.JUnitCore TestListExamples)
test_status=$?

echo "$output"

if [[ $test_status -eq 0 ]]; then
    echo "All tests passed."
    echo "Grade: 100"
else
    failures=$(echo "$output" | grep -o 'failure:' | wc -l)
    echo "Some tests failed. Number of failures: $failures"
    echo "Grade: 0"
fi




