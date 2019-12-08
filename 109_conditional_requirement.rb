#transpose 3x3
#first create a deep copy of the passed in matrix
#two counters, one to count rows and the other for columns. 
#nested loops, outer loop for column, inner for rows 
# switch elements by setting first el = temp then el = el1, then el1 = temp
# end goal is so that matrix[a][b] <-> matrix[b][a]
#break inner loop when iterated element == .last element in given sub-array
#increment both counters by one (to get to next column, and to not overlap elements)
#break when column counter is > arr.size - 1

def transpose(matrix_orig)
 matrix =[]
 matrix_orig.each{|sub| matrix << sub.dup}
    
  row_counter = 0
  column_counter = 0
  loop do
    loop do
      temp = matrix[column_counter][row_counter]
      matrix[column_counter][row_counter] = matrix[row_counter][column_counter]
      matrix[row_counter][column_counter] = temp
      row_counter += 1
      break if row_counter >= matrix[column_counter].size
    end
    column_counter += 1
    row_counter = column_counter
    break if column_counter > matrix.size - 1
  end
  matrix
end

#transpose mxn 
#initialize a row_count and column_count to 0 which correspond to the row and column of the input matrix
#initialize a new result array with dimensions of input_mat
#in the inner loop iterate through a given index (row_count) of each column of the input matrix. 
#append this to the corresponding value in the return matrix (with indices flipped)
#increment column_count by 1 and break when it is equal to the number of columns (size of an input sub array minus one)
#in the outerloop increment row_count by 1, reset column_count to 0 and set breka condition when row_count is > than the input
#array size minus 1 (to account for each sub array)
#return the result array

def transpose(input_mat)
  row_count = 0
  column_count = 0
  result = Array.new(input_mat[0].size){Array.new(input_mat.size)}
  loop do
    loop do
      result[column_count][row_count] = input_mat[row_count][column_count]
      column_count += 1
      break if column_count > input_mat[0].size - 1
    end
    row_count += 1
    column_count = 0
    break if row_count > input_mat.size - 1
  end
  result
end

#merge sorted lists 
#one counter for each input array, iterate the counter whose value was added to the results array
# first check if either of the input arrays are empty. If so return the other and break
# next, find min value of two compared input array values. iterate the counter of the min value array 
# next, check if each counter is greater than the last index in its array. If so, append
# remaining values from other array
# final break condition when the results array is the same size as the two input arrays summed.
# return results array 


def merge(input1,input2)
  counter1 = 0
  counter2 = 0
  result = []
  total_size = input1.size + input2.size
  loop do
    el1 = input1[counter1]
    el2 = input2[counter2]
    if input2.empty?
      result = input1
      break
    elsif input1.empty?
      result = input2
      break
    elsif [el1,el2].min == el1
      result << el1
      counter1 +=1
    else
      result << el2
      counter2 +=1
    end
    if counter1 > input1.size - 1
      loop do
        result << input2[counter2]
        counter2 += 1
        break if counter2 >= input2.size - 1
      end
    end
    if counter2 > input2.size - 1
      loop do
        result << input1[counter1]
        counter1 += 1
        break if counter1 >= input1.size - 1
      end
    end
    break if result.size >= total_size
  end
  result
end

#rotating matrices
#create new matrix to append values to with # rows = orig # of columns and vice versa
#one counter for columns. Initialize it to size of array minus 1 (each row will be a column)
#one counter for rows. initialize at 0. increment by 1 and break when counter is = row.size - 1
#inner loop iterates through the input_row'th element of each column in the input, which is then appended
#to matrix2[input_column][return_column] . return_column is initialized as matrix_input.size - 1
#inner loop is broken out of when last value from input column is appended. 
#in outer loop the input_row is incremented, input_column is reset to 0 and return_column is decremented (we start
#at rightmost column in return and move our way left)
#outer loop breaks when input_row is greater than index of final sub-array in input. 
#return matrix2

def rotate90(matrix_input)
  input_column = 0
  input_row = 0
  return_column = matrix_input.length - 1
  matrix2 = Array.new(matrix_input[0].size){Array.new(matrix_input.size)}
  loop do
    loop do
      matrix2[input_column][return_column] = matrix_input[input_row][input_column]
      input_column += 1
      break if input_column > matrix_input[0].size - 1
    end
    input_row += 1
    input_column = 0
    return_column -= 1
    break if input_row > matrix_input.length - 1
  end
  matrix2
end

#merge sort (recursive)
#assign mid variable equal to ar.length / 2
#divide the input array into two halls first_half and second_half
#recursively call merge_sort on each of these halfs 
# have a return condition if the array.size == 1 (when the array is broken down into one piece)
# finally call merge on the two sub-arrays
# ** I have used the Merge method provided by the assignment. 

def merge(array1, array2)
  index2 = 0
  result = []

  array1.each do |value|
    while index2 < array2.size && array2[index2] <= value
      result << array2[index2]
      index2 += 1
    end
    result << value
  end

  result.concat(array2[index2..-1])
end

def merge_sort(input_array)
  return input_array if input_array.length == 1

  first_half = input_array[0...input_array.length/2]
  second_half = input_array[input_array.length/2...input_array.length]

  first_half = merge_sort(first_half)
  second_half = merge_sort(second_half)

  merge(first_half, second_half)
end