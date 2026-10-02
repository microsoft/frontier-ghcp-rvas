import { TaskPriority, TaskStatus } from '../types/task';
import type { Task } from '../types/task';

export const sampleTasks: Task[] = [
  {
    id: 'task-1',
    title: 'Review keyboard navigation in the task form',
    description: 'Check focus order and returning focus after the dialog closes.',
    status: TaskStatus.IN_PROGRESS,
    priority: TaskPriority.HIGH,
    createdAt: new Date('2026-09-28T09:00:00Z'),
  },
  {
    id: 'task-2',
    title: 'Write an empty-state message',
    status: TaskStatus.TODO,
    priority: TaskPriority.MEDIUM,
    createdAt: new Date('2026-09-29T10:00:00Z'),
  },
  {
    id: 'task-3',
    title: 'Check that a long task title remains readable on a narrow screen without hiding the status or available actions',
    description: 'Use this task when checking the mobile layout.',
    status: TaskStatus.TODO,
    priority: TaskPriority.LOW,
    createdAt: new Date('2026-09-30T11:00:00Z'),
  },
  {
    id: 'task-4',
    title: 'Confirm task status has a text label',
    status: TaskStatus.DONE,
    priority: TaskPriority.MEDIUM,
    createdAt: new Date('2026-10-01T12:00:00Z'),
  },
];
