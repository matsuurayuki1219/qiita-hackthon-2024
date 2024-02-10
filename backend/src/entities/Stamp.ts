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
export class Stamp extends Base {
  @PrimaryGeneratedColumn()
  id: number;
  @ManyToOne(() => Praise, (praise) => praise.stamps)
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

  @Column()
  stamp: string;
}
