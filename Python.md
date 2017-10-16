
```python
# Load a list called numbers
number = raw_input('Enter number:')
numbers = []

# Test condition to break when you enter 'none'
while number!= 'none':
    numbers.append(int(number))
    number = raw_input('Enter number:')
numbers.sort()

# Print Variables
nmin = numbers[0]
nmax = numbers[-1]
tally = len(numbers)
nsum = sum(numbers)
avg = nsum/float(tally)

# Summary Statistics
print "Minimum is " + str(nmin)
print "Maximum is " + str(nmax)
print "Length is " + str(tally)
print "Sum is " + str(nsum)
print "Average is " + str(avg)
```
