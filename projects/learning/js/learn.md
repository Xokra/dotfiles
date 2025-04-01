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

JS Array Method:

<script>
fruits.length; length size of an array

fruits.toString;  convert an array to a string

fruits.at(2);  get the third element the same as fruits[2], but fruits[] can't do -(minus) from the end so it used fruits.at(-1)

fruits.join(" _ "); join all array eleemnts into a string result; Banana _ Orange _ Apple _ Mango

fruits.pop();  removes the last element from an array

fruits.push("Kiwi"); adds a new element to an array at the end

fruits.shift();  removes the first array element and 'shifts' all other elements to a lower index
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
const newArr = myArr.flat();  creates a new array with sub-array elements concatenated to a specified depth
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
