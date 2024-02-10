import {
  Body,
  Controller,
  Get,
  Post,
  Request,
  UnauthorizedException,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth-guard/auth-guard.guard';
import { User } from 'src/models/user/user';
import { LoginRequest } from 'src/request_models/login-request/login-request';
import { PrivateRequest } from 'src/request_models/private-request/private-request';
import { AuthService } from 'src/services/auth/auth.service';
import { UserService } from 'src/services/user/user.service';
import { LoginResponse } from 'src/view_models/login-response/login-response';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    private userService: UserService,
  ) {}

  @Post('login')
  @ApiOperation({ summary: 'ユーザー登録' })
  @ApiCreatedResponse({
    description: 'The record has been successfully created.',
    type: LoginResponse,
  })
  postLogin(@Body() body: LoginRequest) {
    return this.authService.login(body.username);
  }

  @UseGuards(AuthGuard)
  @Get('me')
  @ApiBearerAuth()
  @ApiOperation({ summary: '自分の情報を取得' })
  @ApiOkResponse({
    description: 'The record has been successfully created.',
    type: User,
  })
  getMe(@Request() req: PrivateRequest) {
    // TODO: anyを使わないように修正
    const user = this.userService.findUserById((req.user as any).sub);
    if (user == null) {
      throw new UnauthorizedException();
    }
    return user;
  }
}
