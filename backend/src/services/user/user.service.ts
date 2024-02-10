import { Injectable } from '@nestjs/common';
import { User } from 'src/models/user/user';

@Injectable()
export class UserService {
  private readonly users: User[] = [
    {
      id: 1,
      name: 'John Doe',
    },
  ];

  async login(params: Omit<User, 'id'>): Promise<User | undefined> {
    const existUser = this.users.find((user) => user.name === params.name);
    return existUser;
  }
}
