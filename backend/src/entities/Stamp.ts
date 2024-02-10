import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  JoinColumn,
  ManyToOne,
} from 'typeorm';
import { User } from './User';
import { Base } from './Base';
import { Praise } from './Praise';

@Entity()
export class Stamp extends Base {
  @PrimaryGeneratedColumn('increment')
  id: number;
  @ManyToOne(() => Praise, (praise) => praise.stamps, { lazy: true })
  @JoinColumn({
    name: 'praise_id',
    referencedColumnName: 'id',
  })
  praise: Praise;
  @ManyToOne(() => User, { eager: true })
  @JoinColumn({
    name: 'from_user_id',
    referencedColumnName: 'id',
  })
  fromUser: User;

  @Column()
  stamp: string;
}
