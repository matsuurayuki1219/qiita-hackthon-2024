import { Injectable } from '@nestjs/common';
import { User } from 'src/models/user/user';

@Injectable()
export class UserService {
  private readonly users: User[] = [];

  async register(params: Omit<User, 'id'>): Promise<User> {
    const id = this.users.length + 1;
    const user = new User();
    user.id = id;
    user.name = params.name;
    this.users.push(user);
    return user;
  }
}
