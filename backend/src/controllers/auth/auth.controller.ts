import { Body, Controller, Post } from '@nestjs/common';
import { ApiCreatedResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { LoginRequest } from 'src/request_models/login-request/login-request';
import { AuthService } from 'src/services/auth/auth.service';
import { LoginResponse } from 'src/view_models/login-response/login-response';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('login')
  @ApiOperation({ summary: 'ユーザー登録' })
  @ApiCreatedResponse({
    description: 'The record has been successfully created.',
    type: LoginResponse,
  })
  postLogin(@Body() body: LoginRequest) {
    return this.authService.login(body.username);
  }
}
