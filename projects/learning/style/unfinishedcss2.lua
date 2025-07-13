-- CSS Component Library Plugin for Neovim
-- Advanced CSS components, animations, and utilities for freelance web development

local M = {}

-- Component categories and their snippets
M.components = {
  buttons = {
    glassmorphism = {
      name = "Glassmorphism Button",
      css = [[

.btn-glass {

  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  padding: 12px 24px;
  color: white;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;

  overflow: hidden;
}

.btn-glass:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-2px);

  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}


.btn-glass::before {
  content: '';
  position: absolute;

  top: 0;
  left: -100%;

  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);

  transition: left 0.5s;
}

.btn-glass:hover::before {
  left: 100%;
}]],
      html = [[<button class="btn-glass">Click Me</button>]]
    },

    neumorphism = {
      name = "Neumorphism Button",

      css = [[
.btn-neuro {
  background: #e0e0e0;
  border: none;
  padding: 15px 30px;
  border-radius: 20px;
  box-shadow: 8px 8px 16px #bebebe, -8px -8px 16px #ffffff;
  font-weight: 600;
  color: #333;
  cursor: pointer;
  transition: all 0.3s ease;
}


.btn-neuro:hover {
  box-shadow: 4px 4px 8px #bebebe, -4px -4px 8px #ffffff;
}

.btn-neuro:active {
  box-shadow: inset 4px 4px 8px #bebebe, inset -4px -4px 8px #ffffff;
}]],
      html = [[<button class="btn-neuro">Neumorphic Button</button>]]
    },
    gradient = {
      name = "Gradient Button",

      css = [[
.btn-gradient {
  background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
  border: none;

  padding: 12px 24px;
  border-radius: 25px;
  color: white;
  font-weight: 600;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
}


.btn-gradient:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
}


.btn-gradient::before {

  content: '';
  position: absolute;
  top: 0;

  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(45deg, #764ba2 0%, #667eea 100%);
  opacity: 0;
  transition: opacity 0.3s ease;
}


.btn-gradient:hover::before {
  opacity: 1;

}

.btn-gradient span {

  position: relative;
  z-index: 1;
}]],
      html = [[<button class="btn-gradient"><span>Gradient Button</span></button>]]
    }
  },
  
  cards = {
    glass = {
      name = "Glass Card",
      css = [[
.card-glass {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.card-glass:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
}

.card-glass h3 {
  color: white;
  margin-bottom: 15px;
  font-size: 1.5rem;
}


.card-glass p {
  color: rgba(255, 255, 255, 0.8);
  line-height: 1.6;
}]],
      html = [[
<div class="card-glass">
  <h3>Card Title</h3>
  <p>This is a beautiful glassmorphism card with backdrop blur effects.</p>
</div>]]
    },
    product = {
      name = "Product Card",
      css = [[
.card-product {

  background: white;

  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  max-width: 300px;
}

.card-product:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
}

.card-product img {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.card-product-content {
  padding: 20px;
}

.card-product h3 {
  margin: 0 0 10px 0;

  color: #333;
}


.card-product .price {
  font-size: 1.5rem;
  font-weight: bold;
  color: #667eea;
  margin: 10px 0;

}


.card-product .btn {

  width: 100%;
  padding: 10px;
  background: #667eea;
  color: white;
  border: none;

  border-radius: 5px;
  cursor: pointer;
  transition: background 0.3s ease;
}

.card-product .btn:hover {
  background: #5a67d8;

}]],

      html = [[
<div class="card-product">
  <img src="https://via.placeholder.com/300x200" alt="Product">
  <div class="card-product-content">

    <h3>Product Name</h3>
    <p>Product description goes here...</p>
    <div class="price">$99.99</div>
    <button class="btn">Add to Cart</button>
  </div>
</div>]]
    }
  },
  
  navigation = {
    glass = {
      name = "Glass Navigation",
      css = [[
.nav-glass {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.2);
  padding: 1rem 0;
  position: fixed;
  top: 0;
  left: 0;

  right: 0;
  z-index: 1000;
}


.nav-glass .nav-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;

  align-items: center;
  padding: 0 2rem;

}


.nav-glass .logo {
  font-size: 1.5rem;
  font-weight: bold;
  color: white;
  text-decoration: none;
}

.nav-glass .nav-links {

  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 2rem;
}

.nav-glass .nav-links a {
  color: rgba(255, 255, 255, 0.8);
  text-decoration: none;
  transition: color 0.3s ease;
  position: relative;

}


.nav-glass .nav-links a:hover {
  color: white;
}

.nav-glass .nav-links a::after {
  content: '';
  position: absolute;

  bottom: -5px;
  left: 0;
  width: 0;

  height: 2px;
  background: white;
  transition: width 0.3s ease;
}

.nav-glass .nav-links a:hover::after {
  width: 100%;
}]],
      html = [[
<nav class="nav-glass">
  <div class="nav-container">

    <a href="#" class="logo">Brand</a>
    <ul class="nav-links">
      <li><a href="#home">Home</a></li>
      <li><a href="#about">About</a></li>
      <li><a href="#services">Services</a></li>

      <li><a href="#contact">Contact</a></li>
    </ul>
  </div>
</nav>]]
    },
    sidebar = {
      name = "Sidebar Navigation",
      css = [[
.sidebar {
  position: fixed;
  top: 0;
  left: -300px;
  width: 300px;
  height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

  transition: left 0.3s ease;
  z-index: 1000;
  padding: 2rem 0;
}


.sidebar.active {

  left: 0;
}

.sidebar-header {
  padding: 0 2rem;
  margin-bottom: 2rem;
}


.sidebar-header h2 {
  color: white;
  margin: 0;
}

.sidebar-nav {

  list-style: none;
  padding: 0;

  margin: 0;
}


.sidebar-nav li {
  margin-bottom: 0.5rem;
}

.sidebar-nav a {
  display: block;
  padding: 1rem 2rem;
  color: rgba(255, 255, 255, 0.8);
  text-decoration: none;
  transition: all 0.3s ease;
  position: relative;
}


.sidebar-nav a:hover {
  color: white;
  background: rgba(255, 255, 255, 0.1);
}


.sidebar-nav a::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 4px;

  background: white;

  transform: scaleY(0);
  transition: transform 0.3s ease;
}

.sidebar-nav a:hover::before {
  transform: scaleY(1);
}

.sidebar-overlay {
  position: fixed;
  top: 0;

  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
  z-index: 999;
}

.sidebar-overlay.active {
  opacity: 1;
  visibility: visible;
}

.sidebar-toggle {
  position: fixed;
  top: 1rem;
  left: 1rem;
  background: #667eea;

  color: white;
  border: none;
  padding: 0.5rem;
  border-radius: 5px;
  cursor: pointer;
  z-index: 1001;
}]],
      html = [[
<button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

<div class="sidebar" id="sidebar">

  <div class="sidebar-header">
    <h2>Menu</h2>
  </div>
  <ul class="sidebar-nav">
    <li><a href="#home">Home</a></li>

    <li><a href="#about">About</a></li>
    <li><a href="#services">Services</a></li>
    <li><a href="#portfolio">Portfolio</a></li>

    <li><a href="#contact">Contact</a></li>
  </ul>
</div>

<div class="sidebar-overlay" id="sidebarOverlay" onclick="closeSidebar()"></div>

<script>
function toggleSidebar() {
  const sidebar = document.getElementById('sidebar');
  const overlay = document.getElementById('sidebarOverlay');
  sidebar.classList.toggle('active');
  overlay.classList.toggle('active');
}

function closeSidebar() {
  const sidebar = document.getElementById('sidebar');
  const overlay = document.getElementById('sidebarOverlay');

  sidebar.classList.remove('active');
  overlay.classList.remove('active');
}
</script>]]
    }
  },
  
  forms = {

    glass = {
      name = "Glass Form",
      css = [[
.form-glass {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);

  border-radius: 20px;
  padding: 2rem;
  max-width: 400px;
  margin: 2rem auto;
}

.form-glass h2 {
  color: white;
  text-align: center;
  margin-bottom: 2rem;
}

.form-group {

  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;

  color: rgba(255, 255, 255, 0.8);

  margin-bottom: 0.5rem;
  font-weight: 500;
}


.form-group input,

.form-group textarea {
  width: 100%;
  padding: 12px 16px;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 10px;

  color: white;
  font-size: 1rem;
  transition: all 0.3s ease;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: rgba(255, 255, 255, 0.4);
  background: rgba(255, 255, 255, 0.15);
}

.form-group input::placeholder,
.form-group textarea::placeholder {
  color: rgba(255, 255, 255, 0.5);
}

.form-submit {
  width: 100%;
  padding: 12px;
  background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 10px;
  color: white;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.form-submit:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
}]],

      html = [[
<form class="form-glass">
  <h2>Contact Us</h2>

  <div class="form-group">
    <label for="name">Name</label>
    <input type="text" id="name" name="name" placeholder="Your Name" required>
  </div>
  <div class="form-group">

    <label for="email">Email</label>
    <input type="email" id="email" name="email" placeholder="your@email.com" required>
  </div>
  <div class="form-group">

    <label for="message">Message</label>
    <textarea id="message" name="message" rows="4" placeholder="Your message..." required></textarea>
  </div>
  <button type="submit" class="form-submit">Send Message</button>
</form>]]

    }
  },
  
  animations = {
    fadeIn = {
      name = "Fade In Animation",
      css = [[
@keyframes fadeIn {

  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.fade-in {
  animation: fadeIn 0.6s ease-out;
}

.fade-in-delay-1 {

  animation: fadeIn 0.6s ease-out 0.1s both;
}

.fade-in-delay-2 {
  animation: fadeIn 0.6s ease-out 0.2s both;

}


.fade-in-delay-3 {
  animation: fadeIn 0.6s ease-out 0.3s both;
}]]
    },

    slideIn = {
      name = "Slide In Animation",
      css = [[
@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-50px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes slideInRight {
  from {

    opacity: 0;
    transform: translateX(50px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.slide-in-left {
  animation: slideInLeft 0.6s ease-out;
}

.slide-in-right {
  animation: slideInRight 0.6s ease-out;
}]]
    },
    pulse = {
      name = "Pulse Animation",
      css = [[
@keyframes pulse {
  0% {

    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
  100% {
    transform: scale(1);
  }
}


.pulse {
  animation: pulse 2s infinite;
}

.pulse-slow {
  animation: pulse 3s infinite;
}

.pulse-fast {
  animation: pulse 1s infinite;
}]]
    },
    float = {
      name = "Float Animation",
      css = [[
@keyframes float {
  0% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-20px);
  }
  100% {
    transform: translateY(0px);

  }
}

.float {
  animation: float 3s ease-in-out infinite;
}

.float-slow {
  animation: float 4s ease-in-out infinite;
}

.float-fast {
  animation: float 2s ease-in-out infinite;
}]]
    }
  },
  
  utilities = {
    grid = {
      name = "CSS Grid System",
      css = [[
.grid-container {
  display: grid;
  gap: 2rem;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;

}


.grid-2 {
  grid-template-columns: repeat(2, 1fr);
}

.grid-3 {

  grid-template-columns: repeat(3, 1fr);
}

.grid-4 {
  grid-template-columns: repeat(4, 1fr);
}

.grid-auto {
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
}

.grid-hero {
  grid-template-columns: 1fr 1fr;
  grid-template-rows: 60vh;
  align-items: center;
}

/* Responsive Grid */
@media (max-width: 768px) {
  .grid-2,
  .grid-3,
  .grid-4 {
    grid-template-columns: 1fr;

  }
  
  .grid-hero {
    grid-template-columns: 1fr;
    grid-template-rows: auto;
  }
}

/* Grid Item Utilities */
.grid-span-2 {
  grid-column: span 2;
}

.grid-span-3 {

  grid-column: span 3;
}

.grid-span-full {
  grid-column: 1 / -1;
}]]
    },
    flexbox = {
      name = "Flexbox Utilities",
      css = [[
.flex {
  display: flex;
}

.flex-col {
  flex-direction: column;
}

.flex-row {

  flex-direction: row;
}

.flex-wrap {
  flex-wrap: wrap;
}


.flex-nowrap {
  flex-wrap: nowrap;
}

/* Justify Content */
.justify-start {
  justify-content: flex-start;
}

.justify-center {
  justify-content: center;
}

.justify-end {
  justify-content: flex-end;
}

.justify-between {
  justify-content: space-between;
}

.justify-around {
  justify-content: space-around;
}

.justify-evenly {
  justify-content: space-evenly;
}

/* Align Items */
.items-start {

  align-items: flex-start;
}

.items-center {
  align-items: center;
}


.items-end {
  align-items: flex-end;
}

.items-stretch {
  align-items: stretch;
}

/* Flex Grow/Shrink */
.flex-1 {
  flex: 1;
}

.flex-auto {
  flex: auto;

}


.flex-none {

  flex: none;
}

/* Gap Utilities */
.gap-1 {
  gap: 0.25rem;
}

.gap-2 {
  gap: 0.5rem;

}

.gap-3 {
  gap: 0.75rem;
}

.gap-4 {
  gap: 1rem;
}


.gap-6 {
  gap: 1.5rem;
}

.gap-8 {
  gap: 2rem;
}]]
    },
    spacing = {
      name = "Spacing Utilities",
      css = [[
/* Margin Utilities */
.m-0 { margin: 0; }

.m-1 { margin: 0.25rem; }
.m-2 { margin: 0.5rem; }
.m-3 { margin: 0.75rem; }
.m-4 { margin: 1rem; }

.m-5 { margin: 1.25rem; }
.m-6 { margin: 1.5rem; }
.m-8 { margin: 2rem; }
.m-10 { margin: 2.5rem; }

.m-12 { margin: 3rem; }
.m-16 { margin: 4rem; }
.m-20 { margin: 5rem; }
.m-auto { margin: auto; }

/* Margin Top */

.mt-0 { margin-top: 0; }
.mt-1 { margin-top: 0.25rem; }
.mt-2 { margin-top: 0.5rem; }
.mt-3 { margin-top: 0.75rem; }
.mt-4 { margin-top: 1rem; }
.mt-5 { margin-top: 1.25rem; }
.mt-6 { margin-top: 1.5rem; }
.mt-8 { margin-top: 2rem; }
.mt-10 { margin-top: 2.5rem; }
.mt-12 { margin-top: 3rem; }

.mt-16 { margin-top: 4rem; }
.mt-20 { margin-top: 5rem; }

/* Margin Bottom */
.mb-0 { margin-bottom: 0; }
.mb-1 { margin-bottom: 0.25rem; }
.mb-2 { margin-bottom: 0.5rem; }
.mb-3 { margin-bottom: 0.75rem; }
.mb-4 { margin-bottom: 1rem; }
.mb-5 { margin-bottom: 1.25rem; }
.mb-6 { margin-bottom: 1.5rem; }
.mb-8 { margin-bottom: 2rem; }
.mb-10 { margin-bottom: 2.5rem; }
.mb-12 { margin-bottom: 3rem; }
.mb-16 { margin-bottom: 4rem; }
.mb-20 { margin-bottom: 5rem; }

/* Margin Left */
.ml-0 { margin-left: 0; }
.ml-1 { margin-left: 0.25rem; }

.ml-2 { margin-left: 0.5rem; }
.ml-3 { margin-left: 0.75rem; }
.ml-4 { margin-left: 1rem; }
.ml-5 { margin-left: 1.25rem; }

.ml-6 { margin-left: 1.5rem; }
.ml-8 { margin-left: 2rem; }
.ml-10 { margin-left: 2.5rem; }
.ml-12 { margin-left: 3rem; }
.ml-16 { margin-left: 4rem; }
.ml-20 { margin-left: 5rem; }
.ml-auto { margin-left: auto; }

/* Margin Right */
.mr-0 { margin-right: 0; }
.mr-1 { margin-right: 0.25rem; }
.mr-2 { margin-right: 0.5rem; }

.mr-3 { margin-right: 0.75rem; }
.mr-4 { margin-right: 1rem; }
.mr-5 { margin-right: 1.25rem; }
.mr-6 { margin-right: 1.5rem; }
.mr-8 { margin-right: 2rem; }
.mr-10 { margin-right: 2.5rem; }
.mr-12 { margin-right: 3rem; }
.mr-16 { margin-right: 4rem; }
.mr-20 { margin-right: 5rem; }
.mr-auto { margin-right: auto; }

/* Padding Utilities */

.p-0 { padding: 0; }
.p-1 { padding: 0.25rem; }
.p-2 { padding: 0.5rem; }
.p-3 { padding: 0.75rem; }
.p-4 { padding: 1rem; }
.p-5 { padding: 1.25rem; }
.p-6 { padding: 1.5rem; }
.p-8 { padding: 2rem; }
.p-10 { padding: 2.5rem; }
.p-12 { padding: 3rem; }

.p-16 { padding: 4rem; }
.p-20 { padding: 5rem; }

/* Padding Top */
.pt-0 { padding-top: 0; }
.pt-1 { padding-top: 0.25rem; }
.pt-2 { padding-top: 0.5rem; }
.pt-3 { padding-top: 0.75rem; }
.pt-4 { padding-top: 1rem; }
.pt-5 { padding-top: 1.25rem; }
.pt-6 { padding-top: 1.5rem; }
.pt-8 { padding-top: 2rem; }
.pt-10 { padding-top: 2.5rem; }
.pt-12 { padding-top: 3rem; }
.pt-16 { padding-top: 4rem; }
.pt-20 { padding-top: 5rem; }

/* Padding Bottom */
.pb-0 { padding-bottom: 0; }
.pb-1 { padding-bottom: 0.25rem; }
.pb-2 { padding-bottom: 0.5rem; }
.pb-3 { padding-bottom: 0.75rem; }
.pb-4 { padding-bottom: 1rem; }
.pb-5 { padding-bottom: 1.25rem; }
.pb-6 { padding-bottom: 1.5rem; }
.pb-8 { padding-bottom: 2rem; }
.pb-10 { padding-bottom: 2.5rem; }
.pb-12 { padding-bottom: 3rem; }
.pb-16 { padding-bottom: 4rem; }
.pb-20 { padding-bottom: 5rem; }

/* Padding Left */
.pl-0 { padding-left: 0; }
.pl-1 { padding-left: 0.25rem; }
.pl-2 { padding-left: 0.5rem; }

.pl-3 { padding-left: 0.75rem; }
.pl-4 { padding-left: 1rem; }
.pl-5 { padding-left: 1.25rem; }
.pl-6 { padding-left: 1.5rem; }
.pl-8 { padding-left: 2rem; }
.pl-10 { padding-left: 2.5rem; }
.pl-12 { padding-left: 3rem; }
.pl-16 { padding-left: 4rem; }
.pl-20 { padding-left: 5rem; }

/* Padding Right */
.pr-0 { padding-right: 0; }
.pr-1 { padding-right: 0.25rem; }
.pr-2 { padding-right: 0.5rem; }
.pr-3 { padding-right: 0.75rem; }
.pr-4 { padding-right: 1rem; }
.pr-5 { padding-right: 1.25rem; }
.pr-6 { padding-right: 1.5rem; }
.pr-8 { padding-right: 2rem; }

.pr-10 { padding-right: 2.5rem; }
.pr-12 { padding-right: 3rem; }
.pr-16 { padding-right: 4rem; }
.pr-20 { padding-right: 5rem; }]]

    },
    colors = {
      name = "Modern Color Palette",

      css = [[
:root {
  /* Primary Colors */
  --primary-50: #f0f9ff;
  --primary-100: #e0f2fe;
  --primary-200: #bae6fd;
  --primary-300: #7dd3fc;
  --primary-400: #38bdf8;
  --primary-500: #0ea5e9;
  --primary-600: #0284c7;
  --primary-700: #0369a1
