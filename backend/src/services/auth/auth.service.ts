import { UserService } from './../user/user.service';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { LoginResponse } from 'src/view_models/login-response/login-response';

@Injectable()
export class AuthService {
  constructor(
    private userService: UserService,
    private jwtService: JwtService,
  ) {}

  async login(username: string): Promise<LoginResponse> {
    const user = await this.userService.findUser({ name: username });
    if (user == null) {
      throw new UnauthorizedException();
    }
    const payload = { sub: user.id, username: user.name };
    const accessToken = this.jwtService.sign(payload);

    return {
      ...user,
      access_token: accessToken,
    };
  }
}
