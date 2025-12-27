# Product Development Workflow Skill

> A comprehensive 5-agent product development pipeline for Claude Code

## Overview

The Product Development Workflow is a structured system that orchestrates five specialized AI agents to guide products from concept to development-ready documentation. It automates market research, design specifications, technical architecture, project planning, and development guide generation.

---

## Design Philosophy

### Core Principles

1. **Sequential Expertise**: Each agent specializes in one domain, ensuring depth over breadth
2. **Quality Gates**: Approval checkpoints between phases prevent error propagation
3. **Document as Source of Truth**: All decisions are documented and versioned
4. **Automatic Synchronization**: Changes cascade through dependent documents
5. **Developer-Ready Output**: Final artifacts are immediately actionable

### Why This Approach?

**Traditional Problem**: Product development often suffers from:
- Disconnected documentation
- Lost context between phases
- Manual synchronization overhead
- Inconsistent formats
- Developer onboarding friction

**Our Solution**:
- Unified document chain with dependency tracking
- Automatic sync mechanism with conflict detection
- Standardized templates for consistency
- Synthesized developer guide as single entry point

---

## Architecture

### Agent Hierarchy

```
┌─────────────────────────────────────────────────────────────┐
│                 Product Development Orchestrator            │
│                      /product-init                          │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│    Product    │   │     UIUX      │   │    Product    │
│    Manager    │──▶│    Designer   │──▶│   Architect   │
│     Agent     │   │     Agent     │   │     Agent     │
└───────────────┘   └───────────────┘   └───────────────┘
        │                                       │
        │                                       │
        ▼                                       ▼
┌───────────────────────────────────────────────────────────┐
│                    Project Manager Agent                   │
└───────────────────────────────────────────────────────────┘
                              │
                              ▼
┌───────────────────────────────────────────────────────────┐
│                  Dev Guide Generator Agent                 │
└───────────────────────────────────────────────────────────┘
```

### Document Flow

```
Product Concept
      │
      ▼
┌─────────────┐
│   PRD.md    │ ◀── Market research, features, user stories
└─────────────┘
      │
      ▼
┌─────────────┐
│  UIUX.md    │ ◀── Layouts, components, interactions
└─────────────┘
      │
      ▼
┌─────────────────────┐
│  ARCHITECTURE.md    │ ◀── Tech stack, system design, APIs
└─────────────────────┘
      │
      ▼
┌─────────────┐
│  TODO.md    │ ◀── Tasks, priorities, dependencies
└─────────────┘
      │
      ▼
┌─────────────┐
│ CLAUDE.md   │ ◀── Development guide with auto-sync
└─────────────┘
```

---

## Functionality Matrix

| Command | Purpose | Input | Output |
|---------|---------|-------|--------|
| `/product-init` | Full pipeline | Product concept | All documents |
| `/product-prd` | PRD only | Product name | PRD.md |
| `/product-uiux` | UIUX only | PRD required | UIUX.md |
| `/product-architect` | Architecture only | PRD, UIUX | ARCHITECTURE.md |
| `/product-plan` | Planning only | All prior docs | TODO.md |
| `/product-dev` | Dev guide only | All docs | CLAUDE.md |
| `/product-sync` | Sync all docs | Product name | Updated docs |

---

## Agent Specifications

### 1. Product Manager Agent

**File**: `~/.claude/agents/product-manager.md`

**Responsibilities**:
- Conduct market research via WebSearch
- Analyze 3+ competitors
- Create user personas
- Define features with MoSCoW prioritization
- Document user flows

**Tools Used**:
- `WebSearch` - Market research
- `WebFetch` - Competitor analysis
- `Read`, `Write` - Document management

**Output**: Comprehensive PRD with features, user stories, and flows

### 2. UIUX Designer Agent

**File**: `~/.claude/agents/uiux-designer.md`

**Responsibilities**:
- Design information architecture
- Create page layouts
- Define component library
- Specify interactions and states
- Ensure accessibility (WCAG AA)

**Tools Used**:
- `Read` - PRD analysis
- `Write` - Documentation
- `WebFetch` - Design pattern research

**Output**: Complete UIUX specification with components and tokens

### 3. Product Architect Agent

**File**: `~/.claude/agents/product-architect.md`

**Responsibilities**:
- Select technology stack
- Design system architecture
- Define data models and APIs
- Plan security measures
- Create implementation roadmap

**Tools Used**:
- `WebSearch` - Technology research
- `Context7` - Library documentation
- `codebase-retrieval` - Existing code analysis

**Output**: Technical architecture with diagrams and decisions

### 4. Project Manager Agent

**File**: `~/.claude/agents/project-manager.md`

**Responsibilities**:
- Break down features into tasks
- Assign priorities (P0-P3)
- Map dependencies
- Define milestones
- Estimate effort

**Tools Used**:
- `Read` - Document analysis
- `Write` - TODO generation
- `TodoWrite` - Task tracking

**Output**: Structured TODO with tasks, dependencies, and milestones

### 5. Dev Guide Generator Agent

**File**: `~/.claude/agents/dev-guide-generator.md`

**Responsibilities**:
- Synthesize all documents
- Create quick start guide
- Document code standards
- Set up auto-sync mechanism
- Build troubleshooting section

**Tools Used**:
- `Read` - Document synthesis
- `Write` - Guide generation
- `Serena` - Codebase analysis (if applicable)

**Output**: Developer-ready CLAUDE.md with task sync

---

## Directory Structure

```
{project-root}/
└── products/
    └── {product-name}/
        ├── manifest.json           # Sync metadata and versions
        ├── prd/
        │   ├── PRD.md              # Product Requirements
        │   └── revisions/          # Version history
        ├── uiux/
        │   ├── UIUX.md             # Design Specifications
        │   ├── components/         # Component details
        │   └── assets/             # SVG graphics
        ├── architecture/
        │   ├── ARCHITECTURE.md     # Technical Design
        │   └── diagrams/           # Architecture diagrams
        ├── project/
        │   ├── TODO.md             # Task List
        │   └── milestones.json     # Milestone data
        └── development/
            └── CLAUDE.md           # Development Guide
```

---

## Workflow Execution

### Full Pipeline (/product-init)

```
1. Discovery Phase
   └── Clarify requirements (Quality Gate: 80+ clarity)

2. PRD Generation
   └── Market research + PRD creation
   └── 🛑 USER APPROVAL

3. UIUX Design
   └── Design specs from PRD
   └── 🛑 USER APPROVAL

4. Architecture Design
   └── Technical design from PRD + UIUX
   └── 🛑 USER APPROVAL

5. Project Planning
   └── Task breakdown from all docs
   └── 🛑 USER APPROVAL

6. Dev Guide Generation
   └── Synthesize into CLAUDE.md
   └── ✅ COMPLETE
```

### Standalone Commands

Each phase can run independently:
```bash
/product-prd my-app            # Just PRD
/product-uiux my-app           # Just UIUX (needs PRD)
/product-architect my-app      # Just Architecture
/product-plan my-app           # Just TODO
/product-dev my-app            # Just Dev Guide
```

### Synchronization

```bash
/product-sync my-app           # Detect and update
/product-sync my-app --dry-run # Preview changes
/product-sync my-app --force   # Regenerate all
```

---

## Quality Standards

### Document Completeness

| Document | Minimum Requirements |
|----------|---------------------|
| PRD | 3+ competitors, 5+ features, user flows |
| UIUX | All pages, component library, accessibility |
| Architecture | Stack rationale, diagrams, API contracts |
| TODO | All tasks < 16h, dependencies mapped |
| CLAUDE.md | Quick start works, all refs valid |

### Quality Gates

Each phase has a quality gate:
- **Discovery**: 80+ clarity score
- **PRD**: Complete market analysis
- **UIUX**: Full feature coverage
- **Architecture**: All decisions documented
- **TODO**: No circular dependencies
- **Dev Guide**: All syncs valid

---

## Manifest Schema

```json
{
  "product": {
    "name": "product-name",
    "description": "Product description",
    "created": "2025-01-15T10:00:00Z",
    "updated": "2025-01-15T14:30:00Z"
  },
  "documents": {
    "prd": {
      "version": "1.0.0",
      "path": "./prd/PRD.md",
      "status": "approved",
      "lastModified": "2025-01-15T10:30:00Z",
      "checksum": "sha256-hash"
    },
    "uiux": {
      "version": "1.0.0",
      "path": "./uiux/UIUX.md",
      "status": "approved",
      "lastModified": "2025-01-15T11:00:00Z",
      "dependsOn": { "prd": "1.0.0" }
    },
    "architecture": {
      "version": "1.0.0",
      "dependsOn": { "prd": "1.0.0", "uiux": "1.0.0" }
    },
    "todo": {
      "version": "1.0.0",
      "dependsOn": { "prd": "1.0.0", "uiux": "1.0.0", "architecture": "1.0.0" }
    },
    "claudeMd": {
      "version": "1.0.0",
      "dependsOn": { "prd": "1.0.0", "uiux": "1.0.0", "architecture": "1.0.0", "todo": "1.0.0" }
    }
  },
  "syncStatus": {
    "lastSync": "2025-01-15T14:30:00Z",
    "pendingUpdates": [],
    "conflicts": []
  },
  "workflow": {
    "currentPhase": "development",
    "completedPhases": ["discovery", "prd", "uiux", "architecture", "planning", "guide"]
  }
}
```

---

## Template System

### Available Templates

| Template | Path | Purpose |
|----------|------|---------|
| PRD | `~/.claude/templates/prd-template.md` | Product requirements |
| UIUX | `~/.claude/templates/uiux-template.md` | Design specs |
| Architecture | `~/.claude/templates/architecture-template.md` | Technical design |
| TODO | `~/.claude/templates/todo-template.md` | Task list |
| CLAUDE.md | `~/.claude/templates/claude-md-template.md` | Dev guide |

### Template Features

- YAML frontmatter for metadata
- Mermaid diagram placeholders
- Section markers for auto-sync
- Version tracking headers
- Revision history tables

---

## Synchronization System

### Auto-Update Sections

CLAUDE.md marks sections for automatic updates:
```markdown
<!-- AUTO-SYNC: PRD.md/Executive Summary -->
{Content from PRD}
<!-- END AUTO-SYNC -->
```

### Sync Triggers

| Source Change | Updated Documents |
|---------------|-------------------|
| PRD | UIUX, Architecture, TODO, CLAUDE.md |
| UIUX | Architecture, TODO, CLAUDE.md |
| Architecture | TODO, CLAUDE.md |
| TODO | CLAUDE.md |

### Conflict Resolution

- **Auto-resolved**: New features, text updates
- **Manual review**: Tech changes, priority changes

---

## Best Practices

### For Product Managers
- Provide detailed product concept for better PRD
- Review competitor analysis carefully
- Validate user personas with real data

### For Designers
- Check design prompts reference for patterns
- Ensure accessibility from the start
- Document all component states

### For Architects
- Document decision rationale
- Consider scalability early
- Plan security from the start

### For Developers
- Start with CLAUDE.md quick start
- Follow P0 tasks first
- Run `/product-sync` after changes

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| PRD too vague | Re-run discovery with more questions |
| UIUX missing pages | Check PRD feature coverage |
| Architecture mismatch | Review PRD/UIUX dependencies |
| Circular tasks | Review dependency graph |
| Sync conflicts | Use `--dry-run` to preview |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-01-15 | Initial release |

---

## References

- Design Patterns: https://www.designprompts.dev/
- WCAG Guidelines: https://www.w3.org/WAI/WCAG21/quickref/
- Conventional Commits: https://www.conventionalcommits.org/
- Mermaid Diagrams: https://mermaid.js.org/

---

## License

MIT License - Open source for community use
