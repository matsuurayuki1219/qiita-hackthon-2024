import { Injectable } from '@nestjs/common';
import { User } from 'src/models/user/user';

@Injectable()
export class UserService {
  private readonly users: User[] = [
    {
      id: 1,
      name: 'John Doe',
      status: 'submitter',
    },
    {
      id: 2,
      name: 'Hans Müller',
      status: 'waiting',
    },
  ];

  async findUserByName(params: Pick<User, 'name'>): Promise<User | undefined> {
    const existUser = this.users.find((user) => user.name === params.name);
    return existUser;
  }

  async findUserById(id: number): Promise<User | undefined> {
    const existUser = this.users.find((user) => user.id === id);
    return existUser;
  }

  async getUsers(): Promise<User[]> {
    return this.users;
  }
}
