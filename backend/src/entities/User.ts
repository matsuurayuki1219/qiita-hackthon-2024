import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';
import { Base } from './Base';

export enum UserStatus {
  submitter = 'submitter',
  waiting = 'waiting',
  praised = 'praised',
  others = 'others',
}

@Entity()
export class User extends Base {
  @PrimaryGeneratedColumn()
  id: number;
  @Column()
  name: string;
  @Column({
    type: 'enum',
    enum: UserStatus,
    default: UserStatus.waiting,
  })
  status: 'submitter' | 'waiting' | 'praised' | 'others';
  @Column('text')
  image_url: string;
}
