import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  OneToOne,
  JoinColumn,
  ManyToOne,
} from 'typeorm';
import { User } from './User';
import { Base } from './Base';
import { Praise } from './Praise';

@Entity()
export class Comment extends Base {
  @PrimaryGeneratedColumn()
  id: number;
  @ManyToOne(() => Praise, (praise) => praise.comments)
  @JoinColumn({
    name: 'praise_id',
    referencedColumnName: 'id',
  })
  praise: Praise;
  @OneToOne(() => User)
  @JoinColumn({
    name: 'from_user_id',
    referencedColumnName: 'id',
  })
  fromUser: User;

  @Column({ type: 'text' })
  comment: string;
}
