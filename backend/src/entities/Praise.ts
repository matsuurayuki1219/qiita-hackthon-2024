import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  OneToOne,
  JoinColumn,
  OneToMany,
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

  @OneToOne(() => User)
  @JoinColumn({
    name: 'from_user_id',
    referencedColumnName: 'id',
  })
  fromUser: User;
  @OneToOne(() => User)
  @JoinColumn({
    name: 'to_user_',
    referencedColumnName: 'id',
  })
  toUser: User;

  @OneToMany(() => Stamp, (stamp) => stamp.praise)
  readonly stamps: Stamp[];
  @OneToMany(() => Comment, (comment) => comment.praise)
  readonly comments: Comment[];
}
