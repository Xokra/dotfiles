JS Output:
document.getElementById("demo").innerHTML = "<h2>Hello World</h2>";
document.getElementById("demo").innerText = "Hello World";
<button type="button" onclick="document.write(5+6)">will delete all existing HTML</button>/_testing purposes_/
window.alert(5+6);/_alert box_/
or
alert(5+6);

JS Data Types:
JavaScript Arrays;
const cars = ["Saab", "Volvo", "BMW"];
JavaScript Objects;
const person = {firstName: "John", lastName: "Doe", age:50, eyeColor:"blue"};
The typeof Operator;
typeof "John" //Returns "string"
typeof 0 // Returns "number"

JS Functions:

<p id="demo"></p>
<script>
let text = "The temperature is " + toCelcius(77) + "Celsius.";
document.getElementById("demo").innerHTML = text;
function toCelcius(fahrenheit) {
  return (5/9) * (fahrenheit-32);
}
</script>

JS Objects:
Object Properties;
car properties like weight and color: car.weight = 850kg, car.color = white.

Object Methods;
car has methods like start and stop: car.start(), car.drive(), car.brake(), car.stop().

Using the new Keyword.
const person = new object();
person.firstName = "John";
person.lastName = "Doe";
person.age = 50;
person.eyeColor = "blue";

Object Properties;
Property Value
firstName John
lastName Doe
age 50
eyeColor blue
fullName function() {return this.firstName + " " + this.lastName}
const person = {
firstName : "John",
lastName : "Doe",
id : 5566,
fullName : function() {
return this.firstName + " " + this.lastName;
}
};

Objects are containers for Properties and Methods.
Properties are named Values.
Methods are Functions stored as Properties.
Properties can be primitive values, functions, or even other objects.

7 types of primitive data types:
string, number, boolean, null, undefined, symbol, bigint.

JavaScript Objects are Mutable:

<script>
//Create an Object
const person = {
  firstName : "John",
  lastName: "Doe",
  age:50, eyeColor:"blue"
}
// Try to create a copy
const x = person;
// This will change age in person:
x.age = 10;
</script>

JS Object Properties:
Accessing JavaScript Properties;
let age = person.age;
let age = person["age"];
let age = person[x];

<script>
const person = {
  firstName: "John",
  lastName : "Doe",
  age      : 50
};
let x = "firstName";
let y = "age";
document.getElementById("demo").innerHTML = person[x] + " is " + person[y] + " years old.";
</script>

Deleting Properties;

<script>
const person = {
  firstName: "John",
  lastName: "Doe",
  age: 50,
  eyeColor: "blue"
};
delete person.age;
</script>

Nested Objects;

<script>
const myObj = {
  name: "John",
  age: 30,
  myCars: {
    car1: "Ford",
    car2: "BMW",
    car3: "Fiat"
  }
}
let p1= "myCars";
let p2 = "car2";
document.getElementById("demo").innerHTML = myObj[p1][p2];
</script>

JS Object Methods:
Accesing Object Methods;

<script>
const person = {
firstName: "John",
lastName: "Doe",
id: 5566,
fullName: function() {
return this.firstName + " " + this.lastName;
}
};
document.getElementById("demo").innerHTML= person.fullName();
name = person.fullName(); will execute as a function. // it will show: John Doe
name = person.fullName; will return the function definition. // it will show : function() {return this.firstName + " " + this.lastName;}
</script>

Adding a Method to an Object;
person.name = function () {
return this.firstName + " " + this.lastName;
};

Using JavaScript Methods;
person.name = function () {
return (this.firstName + " " + this.lastName).toUpperCase();
};

JS Object Display:
// Create an Object
const person = {
name: "John",
age: 30,
city: "New York"
};
Displaying Object Properties;
document.getElementById("demo").innerHTML =
person.name + "," + person.age + "," + person.city;
// it will show: John, 30, New York

Displaying Properties in a Loop:
let text = "";
for (let x in person) {
text += person[x] + " ";
};
// Display the Text
document.getElementById("demo").innerHTML = text;
// it will show: John 30 New York

Using Object.values():
const myArray = Object.values(person);
// Display the Array
document.getElementById("demo").innerHTML = myArray;
// it will show: John,30,New York

Using Object.entries():
const fruits = {Bananas: 300, Oranges:200, Apples:500};
let text = "";
for(let [fruit,value] of Object.entries(fruits)) {
text += fruit + ": " + value + "<br>";
}
//it will show:
Bananas: 300
Oranges: 200
Apples: 500

Using Json.stringify():
// Stringify Object
let myString = JSON.stringify(person);
// Display String
document.getElementById("demo").innerHTML = myString;
// it will show: {"name":"John","age":50,"city":"New York"}

JS Object Constructors:
function Person(first, last, age, eye) {
this.firstName = first;
this.lastName = last;
this.age = age;
this.eyeColor = eye;
this.fullName = function() {
return this.firstName + " " + this.lastName
};
}
const myFather = new Person("John", "Doe", 50, "blue");
const myMother = new Person("Sally", "Rally", 48, "green");
// Add a Name Method, will be added to 'myMother'. Not to any other 'Person Objects'.
myMother.changeName = function (name) {
this.lastName = name;
}
// add to 'Person Object'
Person.prototype.changeName = function (name) {
this.lastName = name;
}
// Change Name
myMother.changeName("Doe");

JS String Methods:
JavaScript String Length;
let text = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let length = text.length; //property returns the length of a string.

JavaScript String Characters:
there are 4 methodl for extracting string chacacters:

- The at(position) method; text.at(2)
- The charAt(position) method; text.charAt(2)
- charCodeAt(position) method; text.charCodeAt(2)
- using property access [] like in arrays; text[2]

Extracting String Parts:
there are 3 methods for extracting a part of a string:

- slice(start, end); text.slice(7, 13) or text.slice(-12), extracts a part of a string and returns the exatrected part in a new string
- substring(start, end); similar to slice() but start and end values less than 0 are treated as 0.
- substr(start,length)

Converting to Upper and Lower Case:
text1.toUpperCase();
text1.toLowerCase();

JavaScript String concat():
let text1 = "Hello";
let text2 = "World";
let text 3 = text1.concat(" ", text2); joins two or more strings;

JavaScript String trim()
it will removes whitespace from both sides of a string:
let text1 = " Hello World! ";
let text2 = text1. trim();
document.getElementById("demo").innerHTML=
"Length text1 = " + text.length+ "<br>Length text2 = " + text2.length;
//it will show length text1 = 22, length text2 = 12//

text1.trimStart(); only removes whitespace from the start of a string.
text1.trimEnd(); only removes whitespace from the end of a string.

JavaScript String Padding:
let text= "5";
let padded = text.padStart(4,"0"); pads a string from the start.
// it will show, 0005
let padded = text.padEnd(4,"0"); pads a string from the end.
// it will show, 5000

JavaScript String repeat():
let text = "Hello world!";
let result = text.repeat(2); it will show Hello world! Hello world!.

Replacing String Content:
let text = "Please visit Microsoft!";
let newText = text.replace("Microsoft", "W3Schools");
// it will show Please visit W3Schoodls.
let newText = text.replace(/MICROSOFT/i, "W3Schools"); replace case insensitive
let newText = text.replace(/Microsoft/g, "W3Schools"); replace all matches(global match)
text = text.replaceAll("Cats", "Dogs");

Converting a String to an Array:
text.split(",")
text.split(" ")
text.split("|")
const data = "apple,banana,cherry,date";
const words = data.split(",");
// it will show ['apple', 'banana', 'cherry', 'date']

JS String Search:
JavaScript String indexOf():
let text = "Please locate where 'locate' occurs!";
let index = text.indexOf("locate"); returns the index (position) of the first occurence of a string in a string, or it returns -1 if the string is not fonud:
it will show 7
let index = texi. indexOf("locate", 15); it will show 21

JavaScript String lastIndexOf():
let index = text.lastIndexOf("locate"); returns the index of the last occurence of a specified text in a string.
it will show 21

JavaScript String search():
let text = "Please locate where 'locate' occurs!";
text.search("locate");
text.search(/locate/);

indexOf() and search() they accept the same arguments. These are the differences:

- The search() method cannot take a second start position argument.
- The indexOf() method cannot take powerful search values (regular expressions).

JavaScript String match():
returns an array containing the results of matichng a string against a string(or a regular expression)
let text = " The rain in SPAIN stays mainly in the plain";
text.match("ain");
text.match(/ain/);
text.match(/ain/gi);
text.matchAll(/ain/gi);

JavaScript String includes():
returns true if a string contains a specified value. Otherwise it returns false.
let text = "Hello world, welcome to the universe.";
text.includes("world");
text.includes("world", 12);

JavaScript String startsWith():
returns true if a string begins with a specified value. Otherwise it returns false.
let text = "Hello world, welcome to the universe.";
text.startsWith("Hello"); true
text.startsWith("World"); false
text.startsWith("world", 5); false
text.startsWith("world", 6); true

JavaScript String endsWith():
returns true if as tring ends with a specified value. Otherwise it returns false:
let text / "John Deo";
text.endsWith("Doe"); true
let text = "Hello World, welcome to the universe.";
text.endsWith("world", 11); true, check if the 11 first characters of a string ends with "world":

JS Array Method:

<script>
fruits.length; length size of an array

fruits.toString;  convert an array to a string

fruits.at(2);  get the third element the same as fruits[2], but fruits[] can't do -(minus) from the end so it used fruits.at(-1)

fruits.join(" _ "); join all array eleemnts into a string result; Banana _ Orange _ Apple _ Mango

fruits.pop();  removes the last element from an array

fruits.push("Kiwi"); adds a new element to an array at the end

fruits.shift();  removes the first array element and 'shifts' all other elements to a lower index
const fruits = ["Banana", "Orange", "Apple", "Mango"];
document.getElementById("demo1").innerHTML = fruits.shift(); it will show 'Banana'.
document.getElementById("demo1").innerHTML = fruits;  it will show Banana, Orange, Apple, Mango
fruits.shift();
document.getElementById("demo2").innerHTML = fruits;  it will show Orange, Apple, Mango

fruits.unshift("Lemon");  adds a new element to an array at the beginning, and "unshifts" older elements
document.getElementById("demo1").innerHTML = fruits.unshift("Lemon"); it will show 5.
document.getElementById("demo1").innerHTML = fruits; it will show Banana, Orange, Apple, Mango.
fruits.unshift("Lemon");
document.getElementById("demo2").innerHTML = fruits; it will show Lemon, Banana, Orange, Apple, Mango.

fruits[0] = "Kiwi";  change the first index of the array

fruits[fruits.length] = "Kiwi";  easy way to append a new element to an array

const myGirls = ["Cecilie", "Lone"];
const myBoys = ["Emil", "Tobias", "Linus"];
const myChildren = myGirls.concat(myBoys, arr3);  merging existing arrays

const fruits = ["Banana", "Orange", "Apple", "Mango", "Kiwi", "Papaya"];
document.getElementById("demo").innerHTML =
fruits.copyWithin(2, 0, 2);  copy to index 2, the elements from index 0 to 2
it will show 'Banana, Orange, Banana, Orange, Kiwi, Papaya'

const myArr = [[1,2],[3,4],[5,6]];
const newArr = myArr.flat(); removing inner array, create new array withoutmodifying the original 
it will show '1,2,3,4,5,6'

const myArr = [1, 2 ,3 ,4 ,5 ,6];
const newArr = myArr.flatMap(x => [x, x * 10]);  first map all elements of an array then creates a new array by flattening the array.
it will show '1,10,2,20,3,30,4,40,5,50,6,60'

const fruits = ["Banana", "Orange", "Apple", "Mango"];
fruits.splice(2, 0, "Lemon", "Kiwi");  (2) defines the position where new elements should be added, (0) defines how many elements should be removed.
document.getElementById("dome1").innerHTML = fruits; it will show 'Banana, Orange, Lemon, Kiwi, Apple, Mango'

const months = ["Jan", "Feb", "Mar", "Apr"];
const spliced = months.toSpliced(0, 1);  a safe way to splice an aray without altering the original array.
it will show 'Feb,Mar,Apr'

const fruits = ["Banana", "Orange", "Lemon", "Apple", "Mango"];
const citrus = fruits.slice(3);
document.getElementById("dome1").innerHTML = citrus; it will show 'Apple,Mango'.
when the slice() method is given two arguments, it selects array elements from the start argument, and up to (but not included) the end argument:
const citrus = fruits.slice(1,3);
document.getElementById("dome1").innerHTML = citrus; it will show 'Orange,Lemon'

const fruits = ["Banana", "Orange", "Apple", "Mango"];
document.getElementById("dome1").innerHTML =  fruits.toString(); returns an array as a comma separated string
it will show 'Banana,Orange,Apple,Mango'
</script>

JS Array Search:

<script>
const fruits = ["Apple", "Orange", "Apple", "Mango"];
fruits.indexOf("Apple") + 1; it will show '1'

fruits.lastIndexOf("Apple") + 1; it will show '3'

fruits.includes("Mango"); will show 'true'

const numbers = [4, 9, 16, 25, 29];
let first = numbers.find(myFunction);
function myFunction(value, index, array) {
  return value > 18;
}
document.getElementById("demo").innerHTML = first; it will show '25'

numbers.findIndex(myFunction); it will show '3'

const temp = [27, 28, 30, 40, 42, 35, 30];
let high = temp.findLast(x => x > 40);
document.getElementById("demo").innerHTML = high; it will show '42'

let pos = temp.findLastIndex(x => x > 40);
document.getElementById("demo").innerHTML = pos; it will show '4'
</script>

JS Array Sort:

<script>
fruits.sort(); sort array alphabetically

fruits.reverse(); reverse the elements in an array

fruits.toSorted(); sort an array without altering the original array

fruits.toReversed(); reverse an array without altering the original array.

fruits.sort().reverse(); reverse alphabethically

Numeric Sort:
const arr = [40, 100, 1, 5, 25, 10];
Ascending sort:
arr.sort((a, b) => a - b); it will show '1, 5 ,10, 25, 40, 100'
Descending sort
arr.sort((a, b) => b - a); it will show '100, 40, 25, 10, 5, 1'


Random:
const arr = [40, 100, 1, 5, 25, 10];
function myFunction() {
  arr.sort(function(){return 0.5 - Math.random()});
  document.getElementById("demo").innerHTML = arr;
}

Fisher Yates Method:
function myFunction() {
  for (let i = arr.length -1; i > 0; i--) {
    let j = Math.floor(Math.random() * (i+1));
  [arr[i], arr[j]] = [arr[j], arr[i]] 
  }
}

Min Max:
quick everyday use
const min = Math.min(...arr);
const max = Math.max(...arr);

interview-safe & huge arrays:
function findMinMax(arr) {
    let min = Infinite, max = -Infinite;
    with for:
    for (let num of arr) {
        if (min < num) min = num;
        if (max > num) max = num;
    }

    with while:
    let i = 0;
    while (i < arr.length) {
      if (arr[i] < min) min = arr[i];
      if (arr[i] > max) max = arr[i];
      i++;
    }

    return {min, max};
}

</script>
