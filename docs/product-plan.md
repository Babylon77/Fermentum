# Fermentum Product Plan

## 1. Product vision

Fermentum should become the best free and open-source brewing application for serious hobbyists, clubs, educators, and small producers across beer, cider, wine, and legally compliant distilling workflows.

The product should be:

- Cross-platform from day one: iOS, Android, web, Windows, macOS, Linux.
- Local-first: recipes, brew logs, notes, and calculations work offline.
- Opinionated but flexible: beginner guidance without blocking advanced users.
- Scientifically grounded: calculations and guidance anchored in brewing literature and current style guidelines.
- Interoperable: BeerXML plus a documented Fermentum JSON format.
- Open-source in code and data governance, while still publishable to the App Store and Google Play.

## 2. Research summary

### Homebrew app landscape

Current leaders show a clear split:

- Brewfather is the strongest current benchmark for modern homebrew UX, cross-device access, offline support, recipe design, inventory, fermentation tracking, and device integrations.
- Grainfather is strongest in guided brew-day flow and hardware control, but its mobile ratings are materially weaker than Brewfather's.
- Brewer's Friend is strong in calculators, water chemistry, brew sessions, and groups/collaboration.
- BeerSmith remains deep and feature-rich, especially for equipment, profiles, and advanced calculations, but presents an older product model and weaker mobile satisfaction.
- Brewtarget is the best-known open-source baseline, but it is desktop-only, beer-focused, and behind the leaders in mobile, collaboration, and guided workflows.

### Market facts worth using

- Brewfather advertises cross-device support, offline use, BeerXML import/export, water adjustment with mash pH, batch tracking, inventory, recipe scaling, style guidelines, and broad device integrations. Its Google Play listing shows 4.8/5 with 100K+ downloads, and the App Store page I reviewed showed 5.0/5 in that storefront. Source snapshot: 2026-03-15.
- Grainfather advertises a free app, guided brewing, calculators, recipe library, fermentation device integrations, equipment profiles, and remote control of Grainfather hardware. Its Google Play listing shows 3.5/5 with 50K+ downloads; its US App Store page shows 4.0/5 from 85 ratings. Source snapshot: 2026-03-15.
- Brewer's Friend supports BeerXML, water chemistry, mash chemistry, brew sessions, fermentation devices, and group collaboration. Its Google Play listing shows 4.2/5 with 10K+ downloads; its US App Store page shows 4.0/5 from 10 ratings. Source snapshot: 2026-03-15.
- BeerSmith supports beer, mead, wine, and cider, with strong equipment/profile modeling and cloud/web access, but its Google Play listing shows 3.6/5 with 50K+ downloads. Source snapshot: 2026-03-15.
- Brewtarget is free and open source and supports BeerXML, mash design, priming, pitch rate, brew timers, and desktop cross-platform support.

### What competitors still do poorly

- No product is clearly best across desktop and mobile.
- Beginner onboarding is still weak across the category.
- Equipment recommendation and purchase planning are largely missing.
- Recipe licensing and provenance are messy.
- AI help is mostly shallow or absent.
- Beer-first products often treat cider, wine, and distilling as afterthoughts.
- Open-source options lag badly in UX and mobile support.

### Professional software lessons

Professional brewery, winery, and distillery systems consistently prioritize:

- traceability
- inventory and lot tracking
- production planning
- keg and barrel tracking
- compliance and reporting
- mobile data entry on the floor

That matters because Fermentum should be able to grow from homebrew to advanced enthusiast and nano-brewery workflows without a rewrite.

## 3. Domain foundation

The application should be grounded in the current canonical references instead of inventing its own rules:

- BJCP lists the current official style guidelines as 2021 for beer, 2015 for mead, and 2025 for cider.
- Brewers Association published 2024 beer style guidelines and then added seven new styles on June 6, 2025.
- John Palmer's *How to Brew* remains a foundational homebrewing reference; the website is still based mainly on the 3rd edition while the 4th edition from 2017 is the current published edition.
- Brewers Publications' Brewing Elements series remains the clearest structured reference set for water, yeast, hops, and malt.
- For wine and cider, Scott Labs' current handbooks and Daniel Pambianchi's *Techniques in Home Winemaking* are practical references.
- For distilling, feature design must respect legal boundaries first and process education second.

### Important legal constraint

For US users, home distilling for beverage alcohol is not legal under federal law without the proper TTB qualification. The TTB's current guidance says this explicitly, and its Home Distilling page was last updated March 17, 2025.

Product implication:

- Distilling support in v1 should be framed as education, process logging for licensed operations, recipe formulation, calculations, and compliance-aware workflows.
- The app should not present illegal home distillation as a casual beginner activity in the US.
- Region-aware warnings and legal references should be built in.

## 4. Product thesis

### Core thesis

Build one fermentation platform with beverage-specific workflow layers.

Shared platform:

- ingredients
- water and chemistry
- equipment
- process steps
- temperature and fermentation tracking
- packaging
- tasting notes
- inventory
- AI help
- import/export

Specialized layers:

- beer and cider first
- wine second
- distilling third, with compliance and legality guardrails

This is an inference from the product constraints and the current market, not a direct source claim. It is the lowest-risk way to deliver breadth without creating four unrelated apps.

## 5. Product pillars

### Pillar A: Recipe and formulation

- Fast recipe builder with immediate OG, FG, ABV, IBU, SRM/EBC, pH, attenuation, and cost feedback.
- Equipment-aware scaling by volume, efficiency, gravity target, and losses.
- First-class support for all-grain, extract, BIAB, partial mash, cider, wine, and spirit mash bills.
- Versioning and snapshotting of recipes and brew sessions.
- Public and private recipe libraries with provenance metadata.

### Pillar B: Guided execution

- Brew-day mode with timers, alarms, checklists, deviations, and note capture.
- Fermentation mode with schedules, reminders, sensor feeds, and manual entries.
- Packaging mode for bottling, kegging, carbonation, CO2 planning, and conditioning.
- Post-batch review with tasting notes, defects, learnings, and suggested adjustments.

### Pillar C: Science and calculators

- Water chemistry and mash pH guidance.
- Strike water, mash infusion, sparge, boil-off, and dilution tools.
- Hop utilization including whirlpool and dry-hop aware models.
- Yeast pitch and starter calculators.
- Clarification, fining, filtration, and stability guidance.
- Wine chemistry and cider-specific sugar, acid, sulfite, nutrient, and fermentation tools.

### Pillar D: Equipment intelligence

- Beginner equipment wizard.
- Budget-based recommendations for starter, intermediate, and advanced setups.
- Path-specific advice: stovetop, BIAB, eBIAB, all-in-one electric, cider press, wine kit, vineyard fruit, licensed distillery.
- Equipment profile templates and guided calibration.

### Pillar E: Learning and support

- Experience modes.
- Embedded tutorials.
- Contextual help at every step.
- AI copilot grounded in Fermentum data and curated source material.

## 6. Experience modes

### Apprentice

- Task-oriented guidance
- plain language
- fewer editable fields
- strong defaults
- inline tutorials

### Brewer

- fuller process visibility
- editable profiles
- structured notes
- guided troubleshooting

### Maker

- full calculators
- recipe versioning
- advanced water and fermentation controls
- equipment tuning

### Pro Cellar

- lots, barrels, kegs, traceability, batch genealogy, approvals, and compliance modules

The UI should let users move between modes per workspace, not lock the whole account forever.

## 7. Architecture direction

This section is a recommended technical direction based on the goals above.

### Client architecture

Recommended stack:

- Flutter for iOS, Android, web, Windows, macOS, and Linux
- Rust domain engine for calculations, import/export, sync logic, and deterministic brewing math

Why this direction:

- one UI codebase is the most realistic way to reach mobile and desktop parity
- Rust gives us a trustworthy calculation core, easy testing, and future WASM reuse
- Flutter can deliver a stronger app-store and desktop experience than a web-wrapper strategy

### Data architecture

- SQLite on-device for local-first operation
- documented Fermentum JSON format for backups and full-fidelity import/export
- BeerXML import/export for compatibility
- optional self-hosted sync/community backend using open-source infrastructure

Suggested backend:

- Postgres
- object storage for assets
- a thin API service
- all self-hostable

### License strategy

Recommended:

- client and shared libraries: MPL-2.0 or Apache-2.0
- hosted community/server modules: AGPL-3.0 if we want to prevent closed SaaS forks

Reason:

- app-store distribution is cleaner with permissive or file-level copyleft on the client
- server copyleft can still protect the community platform

This is a product/legal strategy recommendation, not legal advice.

## 8. AI strategy

### Product rule

AI should explain, coach, and retrieve. It should not silently override deterministic brewing calculations.

### Recommended open-source AI approach

Primary assistant:

- Qwen3 family as the general assistant backbone

Reasoning-heavy mode:

- DeepSeek-R1 distilled variants or a larger self-hosted reasoning model for harder troubleshooting and comparative analysis

Why:

- Qwen3's official materials emphasize strong tool use, multilingual support, long context, and local/deployment flexibility.
- DeepSeek-R1's official materials emphasize reasoning strength and open-weight availability.

### AI architecture

- retrieval-augmented generation over curated brewing references, style guidelines, internal help docs, and user data
- deterministic calculation services for recipe math, water chemistry, carbonation, and packaging
- explicit citations in AI answers
- per-answer disclaimer when the system is making an inference instead of citing a source

### AI product features

- ask "what changed if my OG missed by 6 points?"
- explain why a water profile is risky
- suggest step-by-step corrections for stuck fermentation
- recommend equipment by batch size, process, and budget
- convert tasting notes into structured adjustments for the next batch

### Privacy principle

- local-only AI mode should exist for users who do not want cloud processing
- cloud AI should be optional, transparent, and replaceable

## 9. Recipe and content strategy

This is a major risk area.

### Do not do this

- scrape and republish copyrighted recipes from random sites without permission

### Do this instead

- seed the database with licensed, user-submitted, public-domain, or partner-approved recipes
- import open BeerXML and community contributions with attribution and source URLs
- store provenance, author, license, and edit history for every recipe
- build a ranking model around saves, successful brew sessions, ratings, medals, and completion rate

This is the right way to create a "best recipes" library without legal debt.

## 10. MVP definition

### Beverage scope

MVP should ship beer and cider first, with the domain model already capable of wine and distilling extensions.

### MVP feature set

- account-optional local use
- recipes
- equipment profiles
- water chemistry v1
- mash and boil workflow
- fermentation tracking
- packaging calculators
- tasting notes
- BeerXML import/export
- Fermentum JSON import/export
- starter tutorial paths
- beginner and advanced modes
- AI help beta with citations
- curated starter recipe library with clean licensing

### Not in MVP

- full winery lab workflow
- full distillery compliance workflow
- ecommerce
- marketplace
- social feed

## 11. Roadmap

### Phase 0: Foundation

- finalize domain model
- lock licensing strategy
- define source-of-truth calculation engine
- create design system and navigation model
- build recipe, equipment, ingredient, and batch schemas

### Phase 1: Beer and cider MVP

- recipe builder
- brew-day mode
- fermentation mode
- packaging mode
- tasting notes
- offline-first storage
- BeerXML and JSON import/export
- AI help alpha

### Phase 2: Community and hardware

- recipe library
- provenance-aware ratings
- device integrations
- club and shared workspace support
- equipment recommender

### Phase 3: Wine expansion

- must chemistry
- sulfite and nutrient workflows
- style-specific wine guidance
- clarification and filtration workflows
- cellar actions

### Phase 4: Licensed distilling and pro workflows

- legal-region awareness
- batch genealogy
- lots, barrels, and keg tracking
- compliance-oriented reporting
- multi-user approvals

## 12. First 30 days

### Week 1

- set up the monorepo
- choose license
- define core entities
- capture UX principles
- create the calculation-engine test plan

### Week 2

- implement the Rust brewing-core crate
- cover OG, FG, ABV, IBU, color, volume, and scaling calculations with tests
- define BeerXML mapping

### Week 3

- build Flutter shell
- implement local data model and offline persistence
- create recipe builder and equipment profile screens

### Week 4

- build brew-day workflow
- add first tutorial flow
- add AI help spike with citations over a tiny curated source set

## 13. Success metrics

- recipe-to-batch conversion rate
- completed brew sessions per monthly active user
- percentage of users who finish the beginner tutorial
- first-batch success self-rating
- recipe import success rate
- 30-day retention for new brewers
- percentage of AI answers with citations
- mobile and desktop task completion parity

## 14. Immediate repository plan

The next concrete repo artifacts should be:

- `docs/architecture.md`
- `docs/domain-model.md`
- `docs/mvp-backlog.md`
- `docs/design-principles.md`
- `packages/brewing-core/`
- `apps/client/`

## 15. Source list

Homebrew and brewing software:

- Brewfather docs: https://docs.brewfather.app/
- Brewfather recipe designer: https://docs.brewfather.app/recipes/designer
- Brewfather import/export: https://docs.brewfather.app/getting-started/import-recipes
- Brewfather integrations: https://docs.brewfather.app/integrations/tilt-hydrometer
- Brewfather iOS listing: https://apps.apple.com/pt/app/brewfather/id1488585822
- Brewfather Google Play listing: https://play.google.com/store/apps/details?id=com.warpkode.brewfather
- Grainfather app page: https://grainfather.com/brewing-app/
- Grainfather app showcase: https://us.grainfather.com/brewing-app/
- Grainfather recipe import help: https://help.grainfather.com/hc/en-us/articles/12496263554961-Importing-Recipes-into-the-App-Adding-Tags-to-Recipes
- Grainfather US App Store listing: https://apps.apple.com/us/app/grainfather-community/id1169264880
- Grainfather Google Play listing: https://play.google.com/store/apps/details?id=za.co.digitlab.GFConnect
- Brewer's Friend docs: https://docs.brewersfriend.com/
- Brewer's Friend recipe calculator: https://www.brewersfriend.com/homebrew/recipe/calculator
- Brewer's Friend App Store listing: https://apps.apple.com/us/app/brewers-friend/id1580297037
- Brewer's Friend Google Play listing: https://play.google.com/store/apps/details?id=com.brewersfriend.app
- BeerSmith features: https://beersmith.com/features/
- BeerSmith mobile: https://beersmith.com/mobile/
- BeerSmith equipment profiles: https://beersmith.com/equipment-setup/
- BeerSmith Google Play listing: https://play.google.com/store/apps/details?id=com.beersmith.beersmith2full
- Brewtarget features: https://www.brewtarget.org/features.html
- Brewtarget site: https://www.brewtarget.org/
- Brewtarget GitHub: https://github.com/Brewtarget/brewtarget

Professional software:

- Ekos inventory: https://www.goekos.com/role/inventory/
- Ekos lot tracking: https://www.goekos.com/feature/lot-tracking_/
- Ekos TTB reports: https://www.goekos.com/feature/ttb-report-generation_/
- vintrace mobile app: https://www.vintrace.com/en-AU/app-realtime-info/
- DRAMS distillery software overview: https://drams-software.com/

Brewing standards and literature:

- BJCP style guidelines: https://www.bjcp.org/bjcp-style-guidelines/
- Brewers Association 2024 style guidelines release: https://www.brewersassociation.org/association-news/brewers-association-releases-2024-beer-style-guidelines/
- Brewers Association 2025 style additions: https://www.brewersassociation.org/association-news/new-beer-styles-added-to-the-brewers-association-beer-style-guidelines/
- How to Brew: https://howtobrew.com/
- Brewers Publications Brewing Elements series: https://www.brewerspublications.com/collections/brewing-elements-series
- Water: https://www.brewerspublications.com/products/water-a-comprehensive-guide-for-brewers
- Yeast: https://www.brewerspublications.com/products/yeast-the-practical-guide-to-beer-fermentation
- Malt: https://www.brewerspublications.com/products/malt-a-practical-guide-from-field-to-brewhouse
- For the Love of Hops: https://www.brewerspublications.com/products/for-the-love-of-hops-the-practical-guide-to-aroma-bitterness-and-the-culture-of-hops
- Scott Labs home: https://scottlab.com/
- Scott Labs winemaking handbook: https://scottlab.com/winemaking-handbook
- Scott Labs cider faults article: https://scottlab.com/common-cider-sensory-deviations
- Techniques in Home Winemaking: https://techniquesinhomewinemaking.com/techniques-in-home-winemaking/
- Concepts in Wine Chemistry publisher page: https://books.apple.com/us/book/concepts-in-wine-chemistry/id1125818103
- Alcohol Textbook overview: https://www.lbds.com/en/united-states/ethanol-technology-institute/the-alcohol-textbook/

AI:

- Qwen3 GitHub: https://github.com/QwenLM/Qwen3
- Qwen3 model card: https://huggingface.co/Qwen/Qwen3-32B
- DeepSeek-R1 GitHub: https://github.com/deepseek-ai/DeepSeek-R1
- DeepSeek-V3 GitHub: https://github.com/deepseek-ai/DeepSeek-V3

Legal:

- TTB Home Distilling: https://www.ttb.gov/regulated-commodities/beverage-alcohol/distilled-spirits/penalties-for-illegal-distilling
- TTB Alcohol FAQs: https://www.ttb.gov/faqs/alcohol

