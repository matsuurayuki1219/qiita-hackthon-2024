import { UserService } from './../user/user.service';
import { Injectable } from '@nestjs/common';

@Injectable()
export class AuthService {
  constructor(private userService: UserService) {}

  async register(username: string) {
    const user = await this.userService.register({ name: username });
    return user;
  }
}
