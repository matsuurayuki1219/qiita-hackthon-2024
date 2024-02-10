import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  JoinColumn,
  OneToMany,
  ManyToOne,
} from 'typeorm';
import { User } from './User';
import { Base } from './Base';
import { Stamp } from './Stamp';
import { Comment } from './Comment';

@Entity()
export class Praise extends Base {
  @PrimaryGeneratedColumn()
  id: number;
  @Column({ type: 'text' })
  description: string;

  @ManyToOne(() => User, { eager: true })
  @JoinColumn()
  fromUser: User;
  @ManyToOne(() => User, { eager: true })
  @JoinColumn()
  toUser: User;

  @OneToMany(() => Stamp, (stamp) => stamp.praise, { eager: true })
  readonly stamps: Stamp[];
  @OneToMany(() => Comment, (comment) => comment.praise, { eager: true })
  readonly comments: Comment[];
}
