import { Injectable } from '@nestjs/common';
import { User } from 'src/models/user/user';

@Injectable()
export class UserService {
  private users: User[] = [
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
    {
      id: 3,
      name: 'Alice Schmidt',
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

  async switchStatus(praised_user_id: number): Promise<void> {
    // TODO: nestjsはおそらくCGIなので、GB接続しないと変わらない
    this.users = this.users.map((user) => {
      if (user.id === praised_user_id) {
        user.status = 'praised';
      } else {
        user.status = 'others';
      }
      return user;
    });
  }
}
