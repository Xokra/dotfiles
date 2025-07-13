#!/bin/bash

# Client Project Showcase System Setup
# Creates professional demo projects and client materials

set -e


echo "🎨 Setting up Client Project Showcase System..."

# Create main showcase directory structure
mkdir -p ~/freelance-showcase/{demos,client-materials,pricing,templates,assets}

# Create demo projects directory structure
mkdir -p ~/freelance-showcase/demos/{modern-showcase,classic-showcase,creative-showcase,minimal-showcase}


# Create client materials structure
mkdir -p ~/freelance-showcase/client-materials/{proposals,presentations,contracts,questionnaires}

# Create pricing structure
mkdir -p ~/freelance-showcase/pricing/{packages,calculators,estimates}


# Create shared assets
mkdir -p ~/freelance-showcase/assets/{images,icons,fonts,brand}

echo "📁 Directory structure created"

# Create demo project files
echo "🚀 Creating demo projects..."

# Modern Showcase Demo
cat > ~/freelance-showcase/demos/modern-showcase/index.html << 'EOF'
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>TechFlow Solutions - Modern Web Design</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <nav class="navbar">

        <div class="nav-container">
            <div class="nav-brand">
                <h2>TechFlow</h2>
            </div>
            <ul class="nav-menu">
                <li><a href="#home">Home</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact" class="cta-btn">Contact</a></li>
            </ul>
        </div>

    </nav>

    <section id="home" class="hero">
        <div class="hero-container">
            <div class="hero-content">
                <h1>Transform Your Business with <span class="gradient-text">Modern Solutions</span></h1>
                <p>We deliver cutting-edge digital experiences that drive growth and engagement for forward-thinking companies.</p>
                <div class="hero-buttons">
                    <button class="btn-primary">Get Started</button>
                    <button class="btn-secondary">View Portfolio</button>

                </div>
            </div>
            <div class="hero-visual">
                <div class="floating-card">

                    <div class="card-content">
                        <div class="metric">

                            <span class="number">150%</span>
                            <span class="label">Growth</span>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>


    <section id="services" class="services">

        <div class="container">
            <h2>Our Services</h2>

            <div class="services-grid">
                <div class="service-card">
                    <div class="service-icon">🎨</div>
                    <h3>UI/UX Design</h3>
                    <p>Beautiful, intuitive interfaces that users love to interact with.</p>
                </div>
                <div class="service-card">
                    <div class="service-icon">⚡</div>
                    <h3>Performance</h3>

                    <p>Lightning-fast websites optimized for speed and conversions.</p>
                </div>
                <div class="service-card">
                    <div class="service-icon">📱</div>
                    <h3>Responsive</h3>
                    <p>Perfect experience across all devices and screen sizes.</p>
                </div>
            </div>
        </div>

    </section>

    <footer class="footer">

        <div class="container">
            <p>&copy; 2024 TechFlow Solutions. Crafted with precision.</p>
        </div>

    </footer>

    <script src="script.js"></script>
</body>
</html>
EOF

# Modern Showcase CSS
cat > ~/freelance-showcase/demos/modern-showcase/style.css << 'EOF'
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {

    font-family: 'Inter', sans-serif;
    line-height: 1.6;
    color: #333;

    background: #fafafa;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* Navigation */
.navbar {

    background: rgba(255, 255, 255, 0.95);

    backdrop-filter: blur(10px);
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 1000;

    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.nav-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;

    align-items: center;
    height: 70px;
}

.nav-brand h2 {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    font-weight: 700;
}


.nav-menu {
    display: flex;

    list-style: none;

    gap: 30px;
}


.nav-menu a {
    text-decoration: none;
    color: #333;
    font-weight: 500;

    transition: color 0.3s ease;
}


.nav-menu a:hover {
    color: #667eea;
}

.cta-btn {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white !important;
    padding: 10px 20px;
    border-radius: 50px;
    transition: transform 0.3s ease;
}

.cta-btn:hover {
    transform: translateY(-2px);
}

/* Hero Section */
.hero {
    margin-top: 70px;
    padding: 100px 0;

    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    overflow: hidden;
}

.hero-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 60px;
    align-items: center;
}

.hero-content h1 {
    font-size: 3.5rem;
    font-weight: 700;
    margin-bottom: 20px;
    line-height: 1.2;
}


.gradient-text {

    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.hero-content p {
    font-size: 1.2rem;
    margin-bottom: 30px;

    opacity: 0.8;
}

.hero-buttons {

    display: flex;
    gap: 20px;

}


.btn-primary, .btn-secondary {
    padding: 15px 30px;
    border: none;
    border-radius: 50px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;

}


.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
}


.btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 20px 40px rgba(102, 126, 234, 0.3);
}

.btn-secondary {
    background: white;
    color: #333;
    border: 2px solid #667eea;
}

.btn-secondary:hover {

    background: #667eea;
    color: white;
}

/* Hero Visual */
.hero-visual {
    position: relative;
    height: 400px;
}

.floating-card {

    position: absolute;
    top: 50%;
    left: 50%;

    transform: translate(-50%, -50%);
    background: white;

    border-radius: 20px;
    padding: 40px;
    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.1);
    animation: float 6s ease-in-out infinite;

}


@keyframes float {
    0%, 100% { transform: translate(-50%, -50%) translateY(0px); }

    50% { transform: translate(-50%, -50%) translateY(-20px); }
}

.metric {
    text-align: center;
}

.number {
    display: block;

    font-size: 3rem;

    font-weight: 700;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;

    background-clip: text;
}

.label {
    font-size: 1.2rem;
    opacity: 0.7;
    text-transform: uppercase;
    letter-spacing: 2px;

}


/* Services Section */
.services {
    padding: 100px 0;
    background: white;
}

.services h2 {

    text-align: center;
    font-size: 2.5rem;
    margin-bottom: 60px;
    color: #333;
}

.services-grid {
    display: grid;

    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));

    gap: 40px;
}


.service-card {
    text-align: center;

    padding: 40px 30px;
    border-radius: 15px;

    background: #f8f9fa;
    transition: transform 0.3s ease;
}

.service-card:hover {
    transform: translateY(-10px);
}

.service-icon {
    font-size: 3rem;
    margin-bottom: 20px;
}

.service-card h3 {
    font-size: 1.5rem;
    margin-bottom: 15px;
    color: #333;
}

.service-card p {
    opacity: 0.8;

    line-height: 1.6;
}

/* Footer */
.footer {

    background: #333;
    color: white;

    text-align: center;
    padding: 40px 0;
}


/* Responsive Design */

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
    
    .services-grid {
        grid-template-columns: 1fr;
    }
}
EOF

# Modern Showcase JavaScript
cat > ~/freelance-showcase/demos/modern-showcase/script.js << 'EOF'

// Smooth scrolling for navigation
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'

        });

    });
});

// Navbar background on scroll

window.addEventListener('scroll', function() {

    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {

        navbar.style.background = 'rgba(255, 255, 255, 0.98)';
    } else {
        navbar.style.background = 'rgba(255, 255, 255, 0.95)';

    }

});


// Add subtle animations on scroll
const observerOptions = {

    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};


const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {

            entry.target.style.opacity = '1';

            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);


// Observe service cards
document.querySelectorAll('.service-card').forEach(card => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(20px)';
    card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(card);
});
EOF


echo "✅ Modern showcase demo created"


# Create README for the showcase system
cat > ~/freelance-showcase/README.md << 'EOF'

# Client Project Showcase System


A comprehensive system for presenting professional web development services to potential clients.


## Directory Structure


```

freelance-showcase/
├── demos/                    # Live demo projects
│   ├── modern-showcase/      # Modern/Tech company demo
│   ├── classic-showcase/     # Professional/Corporate demo
│   ├── creative-showcase/    # Creative/Agency demo
│   └── minimal-showcase/     # Clean/Minimalist demo
├── client-materials/         # Client-facing documents
│   ├── proposals/           # Proposal templates
│   ├── presentations/       # Client presentations
│   ├── contracts/          # Contract templates

│   └── questionnaires/     # Project requirement forms
├── pricing/                 # Pricing structures
│   ├── packages/           # Service packages
│   ├── calculators/        # Cost calculators

│   └── estimates/          # Quick estimate tools

└── assets/                 # Shared resources
    ├── images/             # Stock photos/graphics
    ├── icons/             # Icon sets
    ├── fonts/             # Typography
    └── brand/             # Your brand assets
```

## Usage

1. **Demo Projects**: Show clients live examples of your work
2. **Client Materials**: Professional documents for client interactions

3. **Pricing**: Transparent pricing structure to close deals
4. **Assets**: Consistent branding across all materials


## Quick Start


```bash
# Navigate to showcase directory
cd ~/freelance-showcase


# Start local server for demos
python3 -m http.server 8000


# View demos at:
# http://localhost:8000/demos/modern-showcase/
# http://localhost:8000/demos/classic-showcase/
# etc.
```

## Professional Positioning


This system positions you as a premium freelancer by:
- Showing actual working examples
- Demonstrating technical competency
- Providing clear pricing structure

- Streamlining client communication

- Maintaining consistent branding
EOF


echo "🎯 Creating client materials..."


# Client Proposal Template

cat > ~/freelance-showcase/client-materials/proposals/web-development-proposal.md << 'EOF'
# Web Development Proposal


**Prepared for:** [CLIENT_NAME]  
**Prepared by:** [YOUR_NAME]  
**Date:** [DATE]  
**Project:** [PROJECT_NAME]


---


## Executive Summary

Thank you for considering our services for your web development project. This proposal outlines our understanding of your requirements and our recommended approach to deliver a professional, high-performing website that exceeds your expectations.

### Key Benefits
- **Modern Design**: Contemporary, professional appearance
- **Mobile-First**: Optimized for all devices
- **Fast Loading**: Performance-optimized code
- **SEO Ready**: Built with search engine optimization
- **Maintenance Friendly**: Easy to update and maintain


---


## Project Understanding

Based on our discussion, you need:
- [ ] Professional website design
- [ ] Mobile-responsive layout
- [ ] Content management capability
- [ ] Contact forms and lead generation
- [ ] SEO optimization
- [ ] Performance optimization

### Target Audience
[Describe the client's target audience]


### Goals

[List the main objectives of the website]


---


## Proposed Solution

### Phase 1: Design & Planning (Week 1)
- Wireframes and mockups

- Design system creation
- Content strategy
- Technical architecture planning

### Phase 2: Development (Weeks 2-3)
- HTML/CSS implementation
- JavaScript functionality
- Mobile optimization
- Cross-browser testing


### Phase 3: Launch & Optimization (Week 4)
- Final testing and debugging
- Performance optimization
- SEO implementation
- Launch and deployment


---


## Deliverables


### What You'll Receive
- ✅ Fully responsive website
- ✅ Source code and assets
- ✅ Basic SEO setup
- ✅ Performance optimization
- ✅ Cross-browser compatibility
- ✅ Mobile-first design
- ✅ Professional documentation
- ✅ 30-day support period


### Optional Add-ons
- Content creation and copywriting
- Advanced SEO package
- E-commerce functionality

- Custom illustrations/graphics
- Extended support package


---

## Investment


### Package Options


**Essential Package - $1,500**

- 5-page professional website

- Mobile-responsive design
- Contact form integration
- Basic SEO setup
- 2 rounds of revisions

**Professional Package - $2,500**
- 8-page professional website
- Custom design system
- Advanced animations

- Performance optimization
- CMS integration
- 3 rounds of revisions

**Premium Package - $4,000**

- 12+ page website
- Custom illustrations

- Advanced functionality
- E-commerce ready
- Advanced SEO
- Priority support
- Unlimited revisions


### Payment Terms
- 50% deposit to begin
- 50% upon completion
- Payment methods: Bank transfer, PayPal, Stripe


---

## Timeline

**Total Project Duration:** 4 weeks

- **Week 1:** Design and planning
- **Week 2:** Core development
- **Week 3:** Advanced features and testing
- **Week 4:** Final optimization and launch

*Timeline may vary based on feedback response times and scope changes.*

---


## Why Choose Us


### Technical Excellence
- Modern, clean code that follows industry standards
- Performance-optimized for fast loading times
- Cross-browser compatibility guaranteed

- Mobile-first responsive design


### Professional Service

- Clear communication throughout the project

- Regular progress updates
- Dedicated project management

- Post-launch support included

### Proven Results
- 98% client satisfaction rate

- Average 40% improvement in loading speed

- 25% increase in mobile engagement
- 100% responsive design guarantee


---


## Next Steps


1. **Review this proposal** and let us know if you have questions

2. **Approve the proposal** and selected package

3. **Sign the contract** and provide initial deposit
4. **Kick-off meeting** to finalize details

5. **Begin development** within 2 business days

---


## Contact Information


**[YOUR_NAME]**  
Web Developer & Designer  
📧 [YOUR_EMAIL]  
📱 [YOUR_PHONE]  
🌐 [YOUR_WEBSITE]

*This proposal is valid for 30 days from the date above.*

---

**Ready to get started?** Let's create something amazing together!
EOF

echo "📋 Creating client questionnaire..."

# Client Questionnaire
cat > ~/freelance-showcase/client-materials/questionnaires/project-requirements.md << 'EOF'
# Project Requirements Questionnaire


**Client Information**
- Company Name: ________________

- Contact Person: ________________

- Email: ________________
- Phone: ________________
- Website (if existing): ________________

---


## Project Overview

**1. What type of website do you need?**
- [ ] Business/Corporate website
- [ ] E-commerce store
- [ ] Portfolio/Gallery

- [ ] Blog/News site
- [ ] Landing page
- [ ] Other: ________________

**2. What is the primary purpose of your website?**

- [ ] Generate leads/inquiries
- [ ] Sell products online

- [ ] Showcase portfolio
- [ ] Provide information
- [ ] Build brand awareness

- [ ] Other: ________________

**3. Who is your target audience?**
________________


**4. What are your main business goals for this website?**
________________


---

## Design & Style

**5. Do you have any design preferences?**

- [ ] Modern and minimalist

- [ ] Classic and professional
- [ ] Creative and artistic

- [ ] Bold and vibrant
- [ ] Clean and simple
- [ ] Other: ________________

**6. What colors would you like to use?**
- Primary color: ________________
- Secondary color: ________________
- Any colors to avoid: ________________


**7. Do you have existing branding materials?**

- [ ] Logo
- [ ] Brand guidelines

- [ ] Color palette

- [ ] Typography
- [ ] None

**8. Are there any websites you admire or want to reference?**
________________

---


## Content & Functionality


**9. How many pages do you need?**
- [ ] 1-5 pages
- [ ] 6-10 pages

- [ ] 11-20 pages
- [ ] 20+ pages

**10. What pages/sections do you need?**
- [ ] Home

- [ ] About

- [ ] Services/Products
- [ ] Contact
- [ ] Blog
- [ ] Portfolio/Gallery
- [ ] Testimonials
- [ ] FAQ
- [ ] Other: ________________


**11. What functionality do you need?**

- [ ] Contact forms

- [ ] Newsletter signup
- [ ] Social media integration
- [ ] Photo galleries
- [ ] Video embedding
- [ ] Online booking
- [ ] E-commerce
- [ ] User accounts
- [ ] Search functionality

- [ ] Other: ________________

**12. Will you provide content (text, images, videos)?**

- [ ] Yes, I'll provide everything
- [ ] Yes, but I need help organizing it
- [ ] No, I need help creating content
- [ ] I need complete content creation


---

## Technical Requirements


**13. Do you need a mobile-responsive design?**

- [ ] Yes, absolutely essential
- [ ] Yes, but not critical
- [ ] No, desktop only

**14. Do you need any integrations?**
- [ ] Google Analytics

- [ ] Social media feeds
- [ ] Email marketing (MailChimp, etc.)
- [ ] CRM system

- [ ] Payment processing
- [ ] Other: ________________

**15. Do you need ongoing maintenance?**
- [ ] Yes, monthly updates

- [ ] Yes, as-needed basis
- [ ] No, I'll handle it myself
- [ ] Unsure

---

## Budget & Timeline

**16. What is your budget range?**

- [ ] Under $1,000

- [ ] $1,000 - $2,500
- [ ] $2,500 - $5,000
- [ ] $5,000 - $10,000
- [ ] $10,000+
- [ ] Need consultation


**17. When do you need the website completed?**

- [ ] ASAP

- [ ] Within 1 month

- [ ] Within 2 months
- [ ] Within 3 months
- [ ] No specific deadline


**18. Are there any important dates or deadlines?**

________________

---

## Additional Information

**19. Do you have web hosting?**
- [ ] Yes, already have hosting
- [ ] No, need hosting recommendation
- [ ] Unsure

**20. Do you have a domain name?**
- [ ] Yes: ________________
- [ ] No, need help choosing one

- [ ] Unsure


**21. Any additional features or requirements?**
________________


**22. Questions or concerns?**
________________


---


**Thank you for taking the time to complete this questionnaire!**

This information helps us create a website that perfectly matches your needs and goals. We'll review your responses and follow up with a detailed proposal within 2 business days.


**Next Steps:**

1. We'll analyze your requirements
2. Create a custom proposal
3. Schedule a consultation call

4. Begin your project upon approval


*Have questions? Contact us at [YOUR_EMAIL] or [YOUR_PHONE]*
EOF

echo "💰 Creating pricing structure..."

# Pricing Packages
cat > ~/freelance-showcase/pricing/packages/service-packages.md << 'EOF'

# Service Packages & Pricing


## Package Overview

### 🚀 Starter Package - $1,200
**Perfect for small businesses and startups**

**Includes:**
- Up to 5 pages
- Mobile-responsive design
- Basic SEO optimization
- Contact form integration

- 2 rounds of revisions
- 30-day support


**Timeline:** 2-3 weeks  
**Best for:** Small businesses, personal websites, simple portfolios


---

### 💼 Professional Package - $2,500
**Ideal for established businesses**


**Includes:**
- Up to 10 pages
- Custom design system
- Advanced animations
- Performance optimization
- CMS integration
- Social media integration

- 3 rounds of revisions
- 60-day support


**Timeline:** 3-4 weeks  
**Best for:** Professional services, consultants, medium businesses


---


### 🎯 Premium Package - $4,500
**For businesses that demand excellence**


**Includes:**
- 15+ pages
- Custom illustrations
- Advanced functionality
- E-commerce ready

- Advanced SEO package
- Analytics setup
- Priority support

- Unlimited revisions
- 90-day support


**Timeline:** 4-6 weeks  
**Best for:** Large businesses, e-commerce, complex requirements

---


## Add-On Services

### Content Creation

- **Copywriting:** $150/page
- **Professional photography:** $300/day

- **Stock photo licensing:** $50/project
- **Logo design:** $500
- **Brand guidelines:** $800

### Technical Services
- **Advanced SEO:** $400

- **Google Analytics setup:** $200
- **E-commerce integration:** $800

- **Custom functionality:** $100/hour

- **Third-party integrations:** $300 each

### Ongoing Support

- **Monthly maintenance:** $150/month

- **Content updates:** $75/hour

- **Emergency support:** $125/hour
- **Hosting management:** $50/month

---

## Payment Structure


### Standard Terms
- **50% deposit** to begin project

- **50% final payment** upon completion
- **Payment methods:** Bank transfer, PayPal, Stripe

- **Late payment fee:** 2% per month


### Rush Jobs
- **25% surcharge** for 2-week delivery
- **50% surcharge** for 1-week delivery
- **100% surcharge** for 48-hour delivery


---


## What's Included in Every Package


### Technical Excellence

✅ Clean, semantic HTML5 code  
✅ Modern CSS3 with flexbox/grid  
✅ Responsive design (mobile-first)  

✅ Cross-browser compatibility  
✅ Performance optimization  
✅ SEO-friendly structure  

### Professional Service
✅ Project management  

✅ Regular progress updates  

✅ Professional communication  
✅ Source code provided  
✅ Documentation included  
✅ Post-launch support  

### Quality Assurance
✅ Multiple device testing  
✅ Cross-browser testing  
✅ Performance testing  
✅ SEO audit  

✅ Code validation  

✅ Security best practices  

---


## Why Our Pricing is Fair


### Value Comparison
| Service | Competitor A | Competitor B | **Our Price** |

|---------|-------------|-------------|---------------|

| 5-page website | $2,000 | $1,800 | **$1,200** |

| Professional design | +$500 | +$400 | **Included** |

| Mobile optimization | +$300 | +$250 | **Included** |

| SEO setup | +$200 | +$300 | **Included** |

| **Total** | **$3,000** | **$2,750** | **$1,200** |


### What You Get Extra
- **Higher quality code** than most competitors
- **Better performance** optimization
- **More responsive** communication
- **Longer support** period
- **Better documentation**

---


## Frequently Asked Questions


**Q: Do you offer refunds?**
A: We offer a 100% satisfaction guarantee. If you're not happy with the initial design concepts, we'll provide a full refund of your deposit.

**Q: What if I need changes after launch?**

A: Minor changes are included in your support period. Major changes are billed at $75/hour.

**Q: Do you provide hosting?**

A: We can recommend hosting providers and help with setup, but hosting costs are separate.


**Q: Can I get a custom quote?**
A: Absolutely! Contact us with your requirements for a personalized proposal.

**Q: Do you work with international clients?**

A: Yes, we work with clients worldwide. All prices are in USD.


---


## Ready to Get Started?


### Quick Quote Calculator
**Basic website (5 pages):** $1,200  
**+ E-commerce:** +$800  

**+ Custom design:** +$500  

**+ Content creation:** +$150/page  

**+ Rush delivery:** +25-100%  

### Next Steps
1. **Choose your package** or request custom quote
2. **Schedule consultation** call

3. **Review proposal** and contract
4. **Pay deposit** to begin
5. **Launch** your amazing website


**Contact us today:** [YOUR_EMAIL] | [YOUR_PHONE]
EOF

echo "🎨 Creating additional demo projects..."

# Create other demo projects (simplified versions)
# Classic Showcase
mkdir -p ~/freelance-showcase/demos/classic-showcase
cat > ~/freelance-showcase/demos/classic-showcase/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sterling & Associates - Professional Services</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Source+Sans+Pro:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>
    <header class="header">
        <nav class="navbar">
            <div class="nav-container">
                <div class="logo">
                    <h1>Sterling & Associates</h1>
                    <p>Professional Legal Services</p>
                </div>
                <ul class="nav-menu">

                    <li><a href="#home">Home</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="#services">Services</a></li>
                    <li><a href="#contact">Contact</a></li>

                </ul>
            </div>
        </nav>
    </header>

    <main>

        <section id="home" class="hero">
            <div class="hero-content">
                <h2>Excellence in Legal Representation</h2>
                <p>With over 25 years of experience, we provide comprehensive legal services with unwavering commitment to our clients.</p>
                <button class="cta-button">Schedule Consultation</button>
            </div>
        </section>


        <section id="services" class="services">
            <div class="container">
                <h2>Our Practice Areas</h2>
                <div class="services-grid">
                    <div class="service-item">
                        <h3>Corporate Law</h3>
                        <p>Comprehensive business legal
