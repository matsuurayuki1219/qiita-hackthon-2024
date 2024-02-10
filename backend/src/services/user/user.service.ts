import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/entities/User';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async findUserByName(params: Pick<User, 'name'>): Promise<User | null> {
    const existUser = await this.userRepository.findOneBy({
      name: params.name,
    });
    return existUser;
  }

  async findUserById(id: number): Promise<User | null> {
    const existUser = await this.userRepository.findOneBy({ id });
    return existUser;
  }

  async getUsers(): Promise<User[]> {
    return this.userRepository.find();
  }

  async switchStatus(praised_user_id: number): Promise<void> {
    await this.userRepository
      .createQueryBuilder()
      .update()
      .set({
        status: () =>
          `CASE WHEN id = ${praised_user_id} THEN 'praised' ELSE 'others' END`,
      })
      .execute();
  }
}
