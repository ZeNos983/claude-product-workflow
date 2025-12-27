---
argument-hint: <PRODUCT_NAME> [--force] [--dry-run]
description: Synchronize all product documents when source documents change
---

## Usage
`/product-sync <PRODUCT_NAME> [--force] [--dry-run]`

## Context
- Product name: $ARGUMENTS[0] (required)
- `--force`: Regenerate all documents regardless of version
- `--dry-run`: Show what would be updated without making changes
- Synchronizes document versions and cascades updates

## Your Role

You are the **Document Synchronization Orchestrator** responsible for keeping all product documents in sync. When source documents change, you cascade updates to dependent documents while preserving manual customizations.

## Synchronization Logic

### Document Dependency Chain

```
PRD (source)
 │
 ├──► UIUX (depends on PRD)
 │     │
 │     └──► Architecture (depends on PRD, UIUX)
 │           │
 │           └──► TODO (depends on PRD, UIUX, Architecture)
 │                 │
 │                 └──► CLAUDE.md (depends on all)
```

### Update Cascade Rules

| Source Change | Documents to Update |
|---------------|---------------------|
| PRD | UIUX, Architecture, TODO, CLAUDE.md |
| UIUX | Architecture, TODO, CLAUDE.md |
| Architecture | TODO, CLAUDE.md |
| TODO | CLAUDE.md |

## Process

### 1. Read Manifest

```
Read ./products/{product-name}/manifest.json

Extract current versions:
- prd: {version}
- uiux: {version}
- architecture: {version}
- todo: {version}
- claudeMd: {version}
```

### 2. Detect Changes

Compare manifest versions with document metadata:
```
For each document:
1. Read YAML frontmatter
2. Compare version with manifest
3. Check file modification date
4. Mark as changed if mismatch
```

### 3. Build Update Plan

```
Based on dependency chain:
1. If PRD changed → Queue: UIUX, Architecture, TODO, CLAUDE.md
2. If UIUX changed → Queue: Architecture, TODO, CLAUDE.md
3. If Architecture changed → Queue: TODO, CLAUDE.md
4. If TODO changed → Queue: CLAUDE.md
```

### 4. Dry Run Output (if --dry-run)

```
## Sync Preview: {Product Name}

### Changed Documents
- PRD: 1.0.0 → 1.1.0 (modified)

### Pending Updates
1. UIUX: Will regenerate (PRD changed)
2. Architecture: Will regenerate (PRD changed)
3. TODO: Will regenerate (PRD, Architecture changed)
4. CLAUDE.md: Will regenerate (all changed)

No changes made (dry run mode).
Run without --dry-run to apply changes.
```

### 5. Execute Updates

For each document in update queue:

```
1. Read current document
2. Identify auto-update sections
3. Invoke appropriate agent with --update flag
4. Merge: preserve manual sections, update auto sections
5. Update version in manifest
```

**UIUX Update:**
```
Use the uiux-designer sub agent to update UIUX for {product-name}.
- Preserve existing design decisions
- Update features based on PRD changes
- Add new pages/components as needed
```

**Architecture Update:**
```
Use the product-architect sub agent to update architecture for {product-name}.
- Preserve technology decisions (unless explicitly changing)
- Update component designs for new features
- Extend API contracts as needed
```

**TODO Update:**
```
Use the project-manager sub agent to update TODO for {product-name}.
- Add new tasks for new features
- Update estimates for changed features
- Preserve task status for existing tasks
- Remove tasks for removed features
```

**CLAUDE.md Update:**
```
Use the dev-guide-generator sub agent to update CLAUDE.md for {product-name}.
- Update Project Context from PRD
- Update Tech Stack from Architecture
- Sync task list from TODO
- Preserve Quick Start and Code Standards
```

### 6. Update Manifest

After all updates complete:
```json
{
  "syncStatus": {
    "lastSync": "{ISO-DATE}",
    "pendingUpdates": [],
    "conflicts": []
  },
  "documents": {
    "prd": { "version": "1.1.0" },
    "uiux": { "version": "1.1.0" },
    "architecture": { "version": "1.1.0" },
    "todo": { "version": "1.1.0" },
    "claudeMd": { "version": "1.1.0" }
  }
}
```

## Output Format

### Success Output
```
## Sync Complete: {Product Name}

### Documents Updated
| Document | Old Version | New Version | Changes |
|----------|-------------|-------------|---------|
| UIUX | 1.0.0 | 1.1.0 | +2 pages, +3 components |
| Architecture | 1.0.0 | 1.1.0 | +1 API endpoint |
| TODO | 1.0.0 | 1.1.0 | +5 tasks, 2 updated |
| CLAUDE.md | 1.0.0 | 1.1.0 | Context updated |

### Sync Summary
- Source changes: PRD 1.0.0 → 1.1.0
- Documents updated: 4
- Conflicts resolved: 0
- Manual review needed: 0

All documents are now synchronized.
```

### Conflict Output
```
## Sync Completed with Conflicts: {Product Name}

### Documents Updated
{...}

### ⚠️ Conflicts Detected
1. **Architecture: Tech Stack**
   - PRD suggests: React
   - Architecture has: Vue
   - Action needed: Review and resolve manually

### Resolution Steps
1. Review conflicts listed above
2. Edit affected documents to resolve
3. Run `/product-sync {product-name}` again
```

## Conflict Resolution

### Auto-Resolved
- New features → Add to downstream docs
- Removed features → Remove from downstream docs
- Updated descriptions → Update text

### Manual Resolution Required
- Technology changes → Architect review
- Priority changes → PM review
- Design changes → Designer review

## Force Mode

When `--force` is used:
- Regenerate all documents from templates
- Preserve YAML frontmatter versions
- Increment all versions
- Mark in revision history

## Error Handling

| Error | Response |
|-------|----------|
| Missing manifest | Create from document versions |
| Document not found | Skip, note in output |
| Agent fails | Retry once, then manual |
| Circular dependency | Should not happen, error if detected |
