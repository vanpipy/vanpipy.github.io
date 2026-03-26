# Leroy Fan

> Senior Software Engineer / Technical Lead | 8 years full-stack experience / 2 years technical leadership
>
> Drive architectural evolution through reversible technical decisions and build team capabilities with replicable development frameworks, delivering end-to-end solutions under ambiguous requirements. Grounded in deep frontend expertise with backend extension, I recently focused on LLM applications, delivering an intelligent NPC from 0 to 1.
>
> Chengdu | vanpipy@gmail.com | +86 177 1152 7177</br>
> [Github](github.com/vanpipy) | [Blog](vanpipy.github.io) | [Linkedin](linkedin.com/in/leroy-fan-8666b0200)

## Core Competencies

* **Back to Basics**: Rapidly validate value through reversible technical approaches (e.g., Feature Flag, anti-corruption layer design), turning ambiguous requirements into business outcomes
* **Technical Decision Making**: Ensure traceable and reviewable choices with clear trade-off criteria (performance/scalability/cost) and fallback paths
* **Architectural Evolution**: Ensure system observability and sustainability through fitness mechanisms and progressive refactoring principles
* **Asset Accumulation**: Identify reuse opportunities through the "Rule of Three", combining effort assessment to transform experience into team-reusable capabilities
* **Collaboration Driven**: Ensure information transparency and efficient flow in 10-person cross-functional teams through contract-first, requirement playback, and iteration retrospectives

## Project Experience

### Xunfeng Digital World Intelligent NPC - Xunfeng Technology

* Context: Native game NPCs primarily used scripted interactions, struggling to cover diverse user queries and multi-turn conversations, with operations lacking configurable role dialogue capabilities
* Goal: Add LLM-based intelligent Q&A capabilities to NPCs while maintaining core game flow, supporting prompt configuration and rapid agent creation to improve operational efficiency and interaction experience
* Actions:
    - Reversible Design: Adopted an anti-corruption layer architecture, encapsulating LLM capabilities as an independent service layer with feature toggle control. Retained original logic as fallback to ensure risk control and quick rollback
    - Technical Decision: Chose "Prompt+RAG" over "fine-tuning", trade-off considerations: a. Maintenance cost (high vs affordable), b. Observability (prompts auditable and traceable), c. Operational self-service level (no additional assistance needed), decision rationale documented for traceability
    - Asset Accumulation: Identified common modules like Prompt template management, dialogue context management, Token billing, extracted as team public capabilities following "Rule of Three", supporting subsequent similar requirement reuse
* Results:
    - Achieved NPC multi-turn intelligent Q&A, operations can quickly adjust role settings and response styles through prompt configuration
    - Dialogue iteration cycle shortened from "2-week release" to "5-minute configuration deployment", debugging costs reduced by ~90%
    - Accumulated LLM component library subsequently supported multiple product lines with similar requirements

### Wuxia Trading Platform - Xunfeng Technology

* Context: Online liquor trading in digital-physical integrated business, multiple business modules, long transaction chains, parallel multi-team development, high frontend-backend collaboration costs, long new module launch cycles
* Goal: Build unified online trading platform, support core transaction flows, improve scalability and delivery efficiency
* Actions:
    - Architectural Evolution: Constrained performance boundaries with fitness mechanisms, defining core page LCP < 1.5s and regular page LCP < 3s as evolution baseline metrics to prevent system degradation from new features
    - Collaboration Driven: Contract-first, promoted "interface design first" mechanism, completed interface design reviews before implementation, reducing interface change rate by 50% during integration phase
    - Asset Accumulation: Accumulated contract tools and business component library, achieved automated interface alignment, transformed new module development from "repetitive implementation" to "component orchestration"
* Results:
    - Core page LCP stabilized within 1.2s
    - New module launch cycle shortened by ~30% (3 weeks to 2 weeks)
    - Transaction chain stably supported business growth, zero failures during major promotions

### Jiaotou Bidding Platform - Xin Jiaotou Big Data

* Context: Traditional bidding processes had many offline links, long cycles, high compliance and audit trail requirements, needing platform support with collaborative meeting capabilities
* Goal: Achieve full online process for tender/bid/opening/evaluation, integrate online meeting room capabilities, improve transparency and delivery efficiency
* Actions:
    - Technical Decision: As Tech Lead, led architecture design and technology selection. For core online meeting capability, chose "integrate third-party SDK" over "in-house development", trade-off considerations: a. Delivery timeline (24 weeks vs 4 weeks), b. Compliance qualifications (information encryption), c. Maintenance cost (non-core functional capability not duplicated), decision rationale documented for subsequent review
    - Architecture Design: Delivered technical solutions and detailed design documentation, defined bidder/tenderer/expert three-party permission models, unified process configuration and component library
    - Collaboration Driven: Established "requirement playback" mechanism, after product side delivered PRD, development side briefly restated to identify ambiguities, reach consensus understanding, only proceeding to technical design phase after review approval
* Results:
    - Platform covered the full tender/bid/opening/evaluation process, supporting 20+ bidding projects online
    - Significantly reduced offline operations and communication costs, milestones achieved as scheduled

### Transaction Fulfillment Platform - KE Holdings

* Context: Complex post-loan fulfillment processes, multiple nodes, frequent cross-system collaboration, with information fragmentation and manual circulation costs
* Goal: Systematize and visualize post-loan processes, accumulate generic capabilities, improve risk control and operational efficiency
* Actions:
    - Architectural Evolution: Constrained refactoring boundaries with fitness mechanisms, defined "core chain response time<500ms" and "unit test coverage>80%" as evolution baselines, ensuring refactoring doesn't introduce regression issues
    - Asset Accumulation: Identified common nodes in fulfillment processes (e.g., approval flows, form engines), extracted as reusable components following "Rule of Three", combined with toolchain and monitoring capabilities to improve issue localization efficiency
    - Collaboration Driven: Promoted post-loan process modeling and cross-system interface alignment with documentation, reducing multi-party integration communication costs
* Results:
    - Achieved systematic control of post-loan key processes
    - Basically eliminated duplicate data entry, manual circulation reduced by 30%
    - Version defect rate decreased by 60% with governance

## Work Experience

### Xunfeng Technology (Guizhou) | Senior Software Engineer | 2023.11 - 2025.12

* Responsible for trading platform full-chain construction and intelligent capability exploration, participated in core module architecture design and team collaboration mechanism improvement
* Skills: LLM/Agent | React | Node.js | Java | MongoDB

### Xin Jiaotou (Chengdu) Big Data | Tech Lead | 2022.07 - 2023.08

* Led team to complete enterprise digital transformation SaaS platform delivery, architecture design, technical solution review, and development process optimization
* Skills: Java | Spring Boot | Spring Cloud | Vue | Microservices Architecture

### KE Holdings | Senior Engineer | 2020.12 - 2022.05

* Participated in real estate financial transaction and post-loan fulfillment platform construction, responsible for micro-frontend architecture and public toolchain accumulation
* Skills: React | Node.js | Webpack | Micro-frontend

### Active Network | Software Engineer | 2019.05 - 2020.08

* Participated in marathon and campus event system development, responsible for key page implementation and agile practice implementation
* Skills: Java | React | Backbone.js | Scrum

### ShenMa Ride-hailing | Tech Lead | 2016.11 - 2019.03

* Led team to complete enterprise mobility business core feature iteration, promoted engineering construction and collaboration mechanism optimization
* Skills: React | Vue | Weex | Scrum

### Dili R&D Center | Frontend Engineer | 2013.08 - 2016.09

* Participated in fresh produce e-commerce platform business development and launch process construction
* Skills: jQuery | Bootstrap | CSS3

## Education
Sichuan University Jinjiang College | Electronic Information Engineering | Bachelor's Degree | *2008 - 2012*

## Acknowledgements
Thank you for taking the time to review my resume. I look forward to the opportunity to work with you.