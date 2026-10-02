// Accessibility Audit Exercise
// This component has 5 intentional accessibility violations.
// Find and fix all of them to achieve WCAG 2.1 AA compliance.

interface CardProps {
  title: string;
  status: 'active' | 'inactive' | 'pending';
  imageUrl: string;
  onAction: () => void;
  details: string;
}

export function AccessibleCard({ title, status, imageUrl, onAction, details }: CardProps) {
  const statusColors = {
    active: '#22c55e',
    inactive: '#ef4444',
    pending: '#f59e0b',
  };

  return (
    // Violation 1: div with click handler but no keyboard accessibility
    <div
      onClick={onAction}
      style={{
        border: '1px solid #e5e7eb',
        borderRadius: '8px',
        padding: '16px',
        cursor: 'pointer',
      }}
    >
      {/* Violation 2: image without alt text */}
      <img src={imageUrl} />

      <h3>{title}</h3>

      {/* Violation 3: status conveyed by color alone */}
      <span
        style={{
          display: 'inline-block',
          width: '12px',
          height: '12px',
          borderRadius: '50%',
          backgroundColor: statusColors[status],
        }}
      />

      <p>{details}</p>

      {/* Violation 4: button without accessible label */}
      <button onClick={(e) => { e.stopPropagation(); onAction(); }}>
        <svg viewBox="0 0 24 24" width="16" height="16">
          <path d="M5 12h14M12 5l7 7-7 7" stroke="currentColor" fill="none" />
        </svg>
      </button>

      {/* Violation 5: modal-like overlay that traps keyboard focus */}
      <div
        className="details-overlay"
        style={{ display: 'none' }}
        tabIndex={0}
        onKeyDown={(e) => {
          // Prevents Escape from closing -- keyboard trap
          if (e.key === 'Escape') {
            e.preventDefault();
            e.stopPropagation();
          }
        }}
      >
        <p>Extended details go here</p>
        <input type="text" placeholder="Add a note" />
      </div>
    </div>
  );
}
