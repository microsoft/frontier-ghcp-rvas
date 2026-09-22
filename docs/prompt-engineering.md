# Prompt Engineering for GitHub Copilot

How to write effective prompts for Copilot's Agent mode in VS Code. For an overview of agents, tools, and context mentions, see the [Copilot Guide](./copilot-guide.md).

## Core Principles

### 1. Be Specific

**Vague:**

```text
create api
```

**Specific:**

```text
Create a REST API for task management with:
- CRUD endpoints for tasks
- JWT authentication middleware  
- Input validation with proper error messages
- Unit tests for all endpoints
- OpenAPI documentation
```

### 2. Provide Examples

**Abstract:**

```text
validate email
```

**With Examples:**

```text
Create email validation that:
- Returns true for: "user@example.com", "name.surname@company.co.uk"
- Returns false for: "invalid", "@example.com", "user@", "user @example.com"
- Uses regex pattern matching
```

### 3. Break Down Complex Tasks

For large tasks, guide the agent through steps:

```text
Implement user authentication:
1. First, create the User model with password hashing
2. Then, implement registration endpoint with validation
3. Next, create login endpoint returning JWT
4. Finally, add auth middleware for protected routes

After each step, run tests before proceeding.
```

## Prompt Patterns

### Pattern 1: The Specification Pattern

Define complete requirements upfront:

```text
Create a 'calculateShippingCost' function that:
- Takes: weight (kg), distance (km), isExpress (boolean)
- Returns: cost in USD (number)
- Formula: baseCost = weight * 0.5 + distance * 0.1
- If express: multiply by 1.5
- Minimum cost: $5
- Maximum cost: $500
- Round to 2 decimal places
- Include unit tests
```

### Pattern 2: The Reference Pattern

Point to existing code as examples:

```text
Following the same patterns as #file:src/services/UserService.ts,
create a ProductService that:
- Has similar error handling
- Uses the same logging approach
- Follows the same test structure
```

### Pattern 3: The Constraint Pattern

Define what NOT to do:

```text
Create a SQL query to get users:
- Do NOT use SELECT *
- Must include WHERE clause for active users only
- Do NOT return password fields
- Limit results to 100
- Order by created_at DESC
```

### Pattern 4: The Workflow Pattern

Define a sequence of agent actions:

```text
Set up a new feature:
1. Create the database migration
2. Generate the model
3. Create API endpoints
4. Add input validation
5. Write integration tests
6. Run all tests to verify
7. Update API documentation
```

## Advanced Techniques

### Multi-Turn Conversations

Build context over multiple messages:

```text
Turn 1: Explain the architecture of this project
Turn 2: Based on that, where should I add a caching layer?
Turn 3: Implement the caching layer you recommended
Turn 4: Add tests for the cache
Turn 5: Run the tests and fix any failures
```

### Combining Tools

```text
Using #fetch to get the Express.js documentation and 
#githubRepo expressjs/express for examples, create a 
middleware that rate-limits requests to 100/minute per IP.
```

### Self-Verification

Ask Agent to verify its own work:

```text
Create a user registration endpoint, then:
- Write tests for it
- Run the tests
- Fix any failures
- Run tests again to confirm all pass
```

```javascript
// Good naming helps Copilot understand context
class UserAuthenticationService {
  // Copilot now knows this relates to auth
  async verifyPasswordAndGenerateToken() {
    // Copilot will suggest auth-related code
  }
}
```

### Leveraging Code Above

```python
# Copilot learns from code you've already written
def process_order(order_id: str) -> OrderResult:
    """Process order with validation and payment"""
    order = validate_order(order_id)
    payment = process_payment(order)
    return create_result(order, payment)

# Now Copilot understands the pattern, so this comment is enough:
def process_refund(refund_id: str) -> RefundResult:
    """Process refund with validation and payment reversal"""
    # Copilot will suggest similar pattern
```

## Language-Specific Tips

### JavaScript/TypeScript

```typescript
// Use JSDoc for better suggestions
/**
 * @param {string} userId - The user's unique identifier
 * @param {Object} options - Configuration options
 * @param {boolean} options.includeDeleted - Include deleted records
 * @returns {Promise<User>} The user object
 * @throws {NotFoundError} When user doesn't exist
 */
async function getUser(userId, options = {}) {
```

### Python

```python
# Use type hints and docstrings
def calculate_discount(
    price: float, 
    discount_percent: float, 
    user_tier: str
) -> float:
    """
    Calculate final price after applying discount.
    
    Args:
        price: Original price in USD
        discount_percent: Discount percentage (0-100)
        user_tier: User membership tier ('basic', 'premium', 'vip')
    
    Returns:
        Final price after discount
        
    Raises:
        ValueError: If discount_percent is not between 0 and 100
    """
```

### SQL

```sql
-- Be explicit about table structure and relationships
-- Users table has: id, name, email, created_at
-- Orders table has: id, user_id, total, status, created_at
-- Get total revenue per user for the last 30 days, only completed orders
```

## Real-World Examples

### Example 1: API Endpoint

```python
# Create FastAPI endpoint for user registration:
# - POST /api/auth/register
# - Request body: email (valid email), password (min 8 chars, 1 uppercase, 1 number)
# - Validate email uniqueness
# - Hash password with bcrypt
# - Create user in database
# - Return 201 with user object (exclude password)
# - Return 400 if validation fails
# - Return 409 if email exists
# - Include proper error messages
@app.post("/api/auth/register")
async def register_user(user_data: UserCreate):
```

### Example 2: React Component

```typescript
/**
 * Create a SearchBar component with:
 * - Controlled input with debouncing (300ms)
 * - Clear button (only shown when input has text)
 * - Search icon
 * - Loading state during search
 * - onSearch callback prop
 * - Accessible (ARIA labels)
 * - TypeScript props interface
 * - Tailwind CSS styling
 */
interface SearchBarProps {
  onSearch: (query: string) => void;
  placeholder?: string;
  isLoading?: boolean;
}

const SearchBar: React.FC<SearchBarProps> = ({ onSearch, placeholder, isLoading }) => {
```

### Example 3: Data Processing

```python
# Transform raw customer data:
# Input: List of dicts with keys: name, email, signup_date (ISO string), status
# Output: DataFrame with columns: customer_id (UUID), name (title case), 
#         email (lowercase), signup_date (datetime), status (categorical),
#         days_since_signup (int), is_active (bool)
# Handle missing values: fill email with 'unknown@example.com', drop rows with missing name
# Sort by signup_date descending
import pandas as pd

def transform_customer_data(raw_data: list[dict]) -> pd.DataFrame:
```

## Reusable Workflows

Use **custom skills** when a task needs a repeatable workflow. Keep ordinary
chat messages for one-off requests and follow-up questions.

Choose the work your skill should cover:

- **Test generation:** identify behavior and edge cases, generate tests in the
  project's framework, then check the results against the requested coverage.
- **Code review:** assess a diff against project conventions and report findings
  with code evidence. Leave specialist judgment to the relevant custom agent.
- **Refactoring:** identify the behavior to preserve, make the scoped change,
  and use tests to check compatibility.

Define the inputs and expected results before authoring the skill. Follow the
[shared skill guidance](../tracks/getting-started.md#custom-skill) for artifact
structure, then use your track's brief to decide what the workflow must achieve.

## Common Pitfalls

### Pitfall 1: Too Vague

```javascript
// bad function
```

**Problem:** Copilot has no idea what you want.

### Pitfall 2: Assuming Knowledge

```python
# implement the algorithm
```

**Problem:** Which algorithm? For what purpose?

### Pitfall 3: No Constraints

```typescript
// fetch user data
```

**Problem:** From where? What format? Error handling?

### Pitfall 4: Over-Complicating

```python
# Create a sophisticated, enterprise-grade, highly scalable, fault-tolerant,
# microservices-based authentication system with blockchain integration
```

**Problem:** Too complex for a single prompt. Break it down!

## Iterative Prompting

Copilot works best with iteration:

**Round 1:**

```javascript
// Create function to validate email
```

**Copilot suggests basic validation**

**Round 2:**

```javascript
// Create function to validate email
// Must support international domains and subdomains
// Return specific error messages for different validation failures
```

**Better result!**

**Round 3: Use Chat**

```text
/explain why doesn't this validate international characters?
[Refine based on explanation]
```

## Measuring Success

Good prompts lead to:

- First suggestion is usable (maybe needs minor tweaks)
- Code follows project patterns
- Includes error handling
- Has appropriate types/validation
- Requires minimal modification

Poor prompts lead to:

- Need to cycle through many suggestions
- Generated code doesn't compile
- Missing critical functionality
- Inconsistent with project style
- Requires complete rewrite

## Practice Exercises

Try improving these prompts:

1. **Before:** `// sort array`
   **After:** _[Your improved version]_

2. **Before:** `# create database`
   **After:** _[Your improved version]_

3. **Before:** `// API call`
   **After:** _[Your improved version]_

## Cheat Sheet

```text
Specific > Vague
Context > Isolation
Examples > Abstraction
Constraints > Freedom
Iterate > One-shot
```

---

[Back to Home](./index.md) | [MCP Servers](./mcp-servers.md)
