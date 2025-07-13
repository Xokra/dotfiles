-- ~/.config/nvim/lua/zedocean/plugins/css-component-generator.lua
-- Phase 2: CSS Component Library Generator
-- Generates reusable CSS components with 3 style variations


return {
  "css-component-generator",
  dir = vim.fn.expand("~/.config/nvim/lua/zedocean/plugins/css-component-generator"),
  config = function()
    local M = {}
    
    -- Component templates for each style
    local components = {
      navigation = {
        glassmorphism = {
          html = [[
<nav class="glass-nav">
  <div class="nav-container">
    <div class="nav-brand">
      <h1>Brand</h1>

    </div>
    <ul class="nav-links">

      <li><a href="#home">Home</a></li>
      <li><a href="#about">About</a></li>
      <li><a href="#services">Services</a></li>
      <li><a href="#contact">Contact</a></li>

    </ul>
    <div class="nav-toggle">
      <span></span>
      <span></span>
      <span></span>
    </div>
  </div>
</nav>]],
          css = [[
.glass-nav {
  position: fixed;
  top: 0;
  width: 100%;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.2);
  z-index: 1000;
}


.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;

}


.nav-brand h1 {
  color: white;
  font-size: 1.5rem;
  font-weight: 700;
}

.nav-links {
  display: flex;
  list-style: none;

  gap: 2rem;

}


.nav-links a {
  color: rgba(255, 255, 255, 0.9);
  text-decoration: none;
  transition: color 0.3s ease;

}

.nav-links a:hover {
  color: #64ffda;
}

.nav-toggle {

  display: none;
  flex-direction: column;
  cursor: pointer;
}

.nav-toggle span {
  width: 25px;
  height: 3px;
  background: white;
  margin: 3px 0;
  transition: 0.3s;
}

@media (max-width: 768px) {
  .nav-links {
    display: none;
  }
  
  .nav-toggle {
    display: flex;
  }
}]]
        },
        
        cyberpunk = {
          html = [[
<nav class="cyber-nav">

  <div class="nav-container">
    <div class="nav-brand">
      <h1>CYBER<span class="accent">BRAND</span></h1>
    </div>
    <ul class="nav-links">
      <li><a href="#home">&gt; HOME</a></li>
      <li><a href="#about">&gt; ABOUT</a></li>
      <li><a href="#services">&gt; SERVICES</a></li>
      <li><a href="#contact">&gt; CONTACT</a></li>
    </ul>
    <div class="nav-toggle">
      <span></span>
      <span></span>
      <span></span>
    </div>
  </div>
</nav>]],
          css = [[
.cyber-nav {
  position: fixed;
  top: 0;
  width: 100%;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 100%);
  border-bottom: 2px solid #00ffff;
  box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);

  z-index: 1000;
}

.nav-container {

  max-width: 1200px;

  margin: 0 auto;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.nav-brand h1 {
  color: #00ffff;
  font-family: 'Courier New', monospace;

  font-size: 1.5rem;
  font-weight: 700;
  text-shadow: 0 0 10px rgba(0, 255, 255, 0.5);
}

.nav-brand .accent {
  color: #ff0080;
}

.nav-links {
  display: flex;
  list-style: none;
  gap: 2rem;
}

.nav-links a {
  color: #00ffff;
  text-decoration: none;
  font-family: 'Courier New', monospace;
  font-weight: 600;
  transition: all 0.3s ease;
  position: relative;
}

.nav-links a:hover {
  color: #ff0080;
  text-shadow: 0 0 5px rgba(255, 0, 128, 0.5);
}

.nav-links a::after {
  content: '';
  position: absolute;
  bottom: -5px;
  left: 0;
  width: 0;
  height: 2px;
  background: #ff0080;
  transition: width 0.3s ease;
}

.nav-links a:hover::after {
  width: 100%;
}

.nav-toggle {
  display: none;
  flex-direction: column;
  cursor: pointer;
}

.nav-toggle span {
  width: 25px;
  height: 3px;
  background: #00ffff;
  margin: 3px 0;
  transition: 0.3s;
}

@media (max-width: 768px) {
  .nav-links {
    display: none;
  }
  
  .nav-toggle {
    display: flex;
  }
}]]
        },
        
        minimalist = {
          html = [[
<nav class="minimal-nav">
  <div class="nav-container">
    <div class="nav-brand">
      <h1>Brand</h1>
    </div>
    <ul class="nav-links">
      <li><a href="#home">Home</a></li>
      <li><a href="#about">About</a></li>
      <li><a href="#services">Services</a></li>
      <li><a href="#contact">Contact</a></li>
    </ul>
    <div class="nav-toggle">
      <span></span>

      <span></span>
      <span></span>
    </div>
  </div>

</nav>]],
          css = [[
.minimal-nav {
  position: fixed;
  top: 0;

  width: 100%;
  background: #ffffff;
  border-bottom: 1px solid #e0e0e0;
  z-index: 1000;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem 2rem;
  display: flex;

  justify-content: space-between;
  align-items: center;
}

.nav-brand h1 {
  color: #333;
  font-size: 1.5rem;
  font-weight: 600;
}

.nav-links {
  display: flex;

  list-style: none;
  gap: 2rem;
}

.nav-links a {
  color: #666;
  text-decoration: none;

  font-weight: 500;
  transition: color 0.3s ease;
}

.nav-links a:hover {
  color: #333;
}

.nav-toggle {
  display: none;
  flex-direction: column;
  cursor: pointer;
}

.nav-toggle span {
  width: 25px;
  height: 2px;
  background: #333;
  margin: 3px 0;
  transition: 0.3s;
}

@media (max-width: 768px) {
  .nav-links {
    display: none;
  }
  
  .nav-toggle {
    display: flex;
  }
}]]

        }
      },
      
      hero = {
        glassmorphism = {
          html = [[
<section class="glass-hero">
  <div class="hero-container">
    <div class="hero-content">
      <h1 class="hero-title">Welcome to the Future</h1>
      <p class="hero-subtitle">Experience the next generation of web design with stunning glassmorphism effects</p>
      <div class="hero-buttons">
        <button class="btn-primary">Get Started</button>
        <button class="btn-secondary">Learn More</button>
      </div>
    </div>
    <div class="hero-visual">
      <div class="glass-orb"></div>
      <div class="glass-orb secondary"></div>
    </div>
  </div>
</section>]],
          css = [[
.glass-hero {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  position: relative;
  overflow: hidden;
}

.hero-container {
  max-width: 1200px;

  margin: 0 auto;
  padding: 2rem;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.hero-content h1 {
  font-size: 3.5rem;
  color: white;
  margin-bottom: 1rem;
  font-weight: 700;
}

.hero-subtitle {
  font-size: 1.2rem;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 2rem;
  line-height: 1.6;
}


.hero-buttons {
  display: flex;
  gap: 1rem;
}

.btn-primary, .btn-secondary {
  padding: 1rem 2rem;
  border: none;

  border-radius: 10px;
  font-size: 1rem;

  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-primary {
  background: rgba(255, 255, 255, 0.2);
  color: white;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.3);
}

.btn-primary:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

.btn-secondary {
  background: transparent;
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.5);
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
  transform: translateY(-2px);
}

.hero-visual {

  position: relative;
  height: 400px;
}

.glass-orb {
  position: absolute;
  width: 200px;
  height: 200px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  backdrop-filter: blur(10px);

  border: 1px solid rgba(255, 255, 255, 0.2);
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.glass-orb.secondary {
  width: 150px;
  height: 150px;

  background: rgba(255, 255, 255, 0.05);
  top: 20%;
  left: 20%;
}

@media (max-width: 768px) {
  .hero-container {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .hero-content h1 {
    font-size: 2.5rem;
  }
  
  .hero-buttons {
    justify-content: center;
  }
}]]
        },
        
        cyberpunk = {
          html = [[
<section class="cyber-hero">
  <div class="hero-container">
    <div class="hero-content">
      <h1 class="hero-title">ENTER THE <span class="accent">MATRIX</span></h1>
      <p class="hero-subtitle">&gt; Cyberpunk web design for the digital future</p>
      <div class="hero-buttons">
        <button class="btn-primary">JACK IN</button>
        <button class="btn-secondary">EXPLORE</button>
      </div>
    </div>
    <div class="hero-visual">
      <div class="cyber-grid"></div>
      <div class="neon-box"></div>
    </div>
  </div>
</section>]],
          css = [[
.cyber-hero {
  min-height: 100vh;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 100%);
  display: flex;

  align-items: center;
  position: relative;
  overflow: hidden;
}

.cyber-hero::before {
  content: '';
  position: absolute;

  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: repeating-linear-gradient(
    90deg,
    transparent,
    transparent 100px,

    rgba(0, 255, 255, 0.05) 100px,
    rgba(0, 255, 255, 0.05) 101px
  );
}

.hero-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
  position: relative;
  z-index: 1;

}


.hero-content h1 {
  font-size: 3.5rem;
  color: #00ffff;
  margin-bottom: 1rem;
  font-weight: 700;
  font-family: 'Courier New', monospace;
  text-shadow: 0 0 20px rgba(0, 255, 255, 0.5);

}


.hero-content .accent {
  color: #ff0080;
}

.hero-subtitle {
  font-size: 1.2rem;
  color: #00ffff;
  margin-bottom: 2rem;
  font-family: 'Courier New', monospace;
  font-weight: 500;
}

.hero-buttons {
  display: flex;
  gap: 1rem;
}

.btn-primary, .btn-secondary {
  padding: 1rem 2rem;
  border: none;
  border-radius: 5px;

  font-size: 1rem;
  font-weight: 600;
  font-family: 'Courier New', monospace;
  cursor: pointer;
  transition: all 0.3s ease;
  text-transform: uppercase;
}

.btn-primary {
  background: linear-gradient(135deg, #00ffff 0%, #ff0080 100%);
  color: #000;

  box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 0 30px rgba(0, 255, 255, 0.5);
}

.btn-secondary {
  background: transparent;

  color: #00ffff;
  border: 2px solid #00ffff;
  box-shadow: 0 0 10px rgba(0, 255, 255, 0.2);
}


.btn-secondary:hover {
  background: rgba(0, 255, 255, 0.1);
  transform: translateY(-2px);
  box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
}

.hero-visual {
  position: relative;
  height: 400px;
}

.cyber-grid {
  position: absolute;
  width: 100%;
  height: 100%;
  background: 
    linear-gradient(rgba(0, 255, 255, 0.1) 1px, transparent 1px),
    linear-gradient(90deg, rgba(0, 255, 255, 0.1) 1px, transparent 1px);
  background-size: 20px 20px;
}

.neon-box {
  position: absolute;
  width: 200px;
  height: 200px;
  border: 2px solid #00ffff;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);

  box-shadow: 
    0 0 20px rgba(0, 255, 255, 0.5),
    inset 0 0 20px rgba(0, 255, 255, 0.2);
  animation: neonPulse 2s ease-in-out infinite alternate;

}


@keyframes neonPulse {
  from {

    box-shadow: 
      0 0 20px rgba(0, 255, 255, 0.5),
      inset 0 0 20px rgba(0, 255, 255, 0.2);

  }
  to {
    box-shadow: 
      0 0 30px rgba(0, 255, 255, 0.8),

      inset 0 0 30px rgba(0, 255, 255, 0.4);
  }

}


@media (max-width: 768px) {
  .hero-container {
    grid-template-columns: 1fr;
    text-align: center;

  }
  
  .hero-content h1 {
    font-size: 2.5rem;
  }
  
  .hero-buttons {
    justify-content: center;
  }
}]]
        },
        
        minimalist = {

          html = [[
<section class="minimal-hero">
  <div class="hero-container">

    <div class="hero-content">
      <h1 class="hero-title">Simple. Clean. Effective.</h1>
      <p class="hero-subtitle">Beautiful minimalist design that focuses on what matters most</p>
      <div class="hero-buttons">
        <button class="btn-primary">Get Started</button>

        <button class="btn-secondary">Learn More</button>
      </div>
    </div>
    <div class="hero-visual">

      <div class="minimal-shape"></div>

    </div>
  </div>
</section>]],
          css = [[
.minimal-hero {
  min-height: 100vh;
  background: #f8f9fa;
  display: flex;
  align-items: center;
}

.hero-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;

}


.hero-content h1 {
  font-size: 3.5rem;
  color: #333;
  margin-bottom: 1rem;
  font-weight: 300;
  line-height: 1.2;
}

.hero-subtitle {
  font-size: 1.2rem;
  color: #666;

  margin-bottom: 2rem;
  line-height: 1.6;
}

.hero-buttons {
  display: flex;

  gap: 1rem;

}


.btn-primary, .btn-secondary {
  padding: 1rem 2rem;
  border: none;
  border-radius: 5px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-primary {
  background: #333;
  color: white;
}

.btn-primary:hover {

  background: #555;

  transform: translateY(-2px);
}

.btn-secondary {
  background: transparent;
  color: #333;
  border: 2px solid #333;

}


.btn-secondary:hover {
  background: #333;
  color: white;
  transform: translateY(-2px);
}


.hero-visual {
  position: relative;
  height: 400px;
  display: flex;
  align-items: center;

  justify-content: center;
}

.minimal-shape {
  width: 200px;
  height: 200px;
  background: #333;
  border-radius: 10px;
  transform: rotate(45deg);
  opacity: 0.1;
}

@media (max-width: 768px) {
  .hero-container {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .hero-content h1 {
    font-size: 2.5rem;
  }
  
  .hero-buttons {
    justify-content: center;
  }
}]]
        }
      },
      
      card = {
        glassmorphism = {
          html = [[
<div class="glass-card">
  <div class="card-header">
    <h3>Card Title</h3>
  </div>
  <div class="card-body">
    <p>This is a beautiful glassmorphism card with a translucent background and blur effect.</p>
  </div>
  <div class="card-footer">
    <button class="card-btn">Learn More</button>
  </div>

</div>]],
          css = [[
.glass-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
  transition: transform 0.3s ease;
  max-width: 300px;
}

.glass-card:hover {
  transform: translateY(-5px);
}

.card-header h3 {
  color: white;
  margin-bottom: 1rem;
  font-size: 1.5rem;
  font-weight: 600;
}

.card-body p {
  color: rgba(255, 255, 255, 0.9);
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.card-footer {
  display: flex;
  justify-content: flex-end;
}

.card-btn {
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.3);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(5px);
}

.card-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}]]
        },
        
        cyberpunk = {
          html = [[
<div class="cyber-card">
  <div class="card-header">
    <h3>&gt; CYBER_CARD.EXE</h3>
  </div>
  <div class="card-body">
    <p>// Cyberpunk styled card component</p>
    <p>// With neon effects and grid patterns</p>
  </div>
  <div class="card-footer">
    <button class="card-btn">EXECUTE</button>
  </div>
</div>]],
          css = [[
.cyber-card {
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 100%);
  border: 2px solid #00ffff;
  border-radius: 5px;
  padding: 2rem;
  box-shadow: 
    0 0 20px rgba(0, 255, 255, 0.3),
    inset 0 0 20px rgba(0, 255, 255, 0.1);
  transition: all 0.3s ease;
  max-width: 300px;
  position: relative;
}

.cyber-card::before {
  content: '';

  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    linear-gradient(rgba(0, 255, 255, 0.05) 1px, transparent 1px),
    linear-gradient(90deg, rgba(0, 255, 255, 0.05) 1px, transparent 1px);
  background-size: 10px 10px;
  pointer-events: none;
}

.cyber-card:hover {
  transform: translateY(-5px);
  box-shadow: 
    0 0 30px rgba(0, 255, 255, 0.5),
    inset 0 0 30px rgba(0, 255, 255, 0.2);
}

.card-header h3 {
  color: #00ffff;
  margin-bottom: 1rem;
  font-size: 1.5rem;
  font-weight: 600;
  font-family: 'Courier New', monospace;
  text-shadow: 0 0 10px rgba(0, 255, 255, 0.5);

}


.card-body p {
  color: #00ffff;

  line-height: 1.6;
  margin-bottom: 0.5rem;
  font-family: 'Courier New', monospace;
  font-size: 0.9rem;
}

.card-footer {
  display: flex;
  justify-content: flex-end;
  margin-top: 1.5rem;
}


.card-btn {
  background: linear-gradient(135deg, #00ffff 0%, #ff0080 100%);
  border: none;
  color: #000;
  padding: 0.5rem 1rem;
  border-radius: 3px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-family: 'Courier New', monospace;
  font-weight: 600;
  text-transform: uppercase;
  box-shadow: 0 0 10px rgba(0, 255, 255, 0.3);
}

.card-btn:hover {

  transform: translateY(-2px);
  box-shadow: 0 0 20px rgba(0, 255, 255, 0.5);
}]]
        },
        
        minimalist = {
          html = [[
<div class="minimal-card">
  <div class="card-header">
    <h3>Card Title</h3>
  </div>
  <div class="card-body">
    <p>Clean and simple card design that focuses on content and readability.</p>
  </div>
  <div class="card-footer">

    <button class="card-btn">Learn More</button>
  </div>

</div>]],
          css = [[
.minimal-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;

  padding: 2rem;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  max-width: 300px;
}

.minimal-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.card-header h3 {
  color: #333;
  margin-bottom: 1rem;
  font-size: 1.5rem;
  font-weight: 600;

}


.card-body p {
  color: #666;
  line-height: 1.6;
  margin-bottom: 1.5rem;

}


.card-footer {
  display: flex;
  justify-content: flex-end;
}

.card-btn {
  background: #333;
  border: none;

  color: white;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 500;
}

.card-btn:hover {
  background: #555;
  transform: translateY(-2px);
}]]
        }
      },
      

      button = {
        glassmorphism = {
          html = [[
<button class="glass-btn">Glass Button</button>
<button class="glass-btn secondary">Secondary</button>
<button class="glass-btn outline">Outline</button>]],

          css = [[
.glass-btn {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  color: white;
  padding: 1rem 2rem;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 600;
  margin: 0.5rem;
}

.glass-btn:hover {

  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(255, 255, 255, 0.2);
}

.glass-btn.secondary {
  background: rgba(100, 255, 218, 0.2);
  border-color: rgba(100, 255, 218, 0.3);
  color: #64ffda;
}

.glass-btn.secondary:hover {
  background: rgba(100, 255, 218, 0.3);
  box-shadow: 0 5px 15px rgba(100, 255, 218, 0.2);
}

.glass-btn.outline {
  background: transparent;
  border: 2px solid rgba(255, 255, 255, 0.5);
}

.glass-btn.outline:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255,
