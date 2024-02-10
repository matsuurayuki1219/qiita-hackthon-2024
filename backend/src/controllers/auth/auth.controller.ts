import { Body, Controller, Post } from '@nestjs/common';
import { ApiCreatedResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { AuthService } from 'src/services/auth/auth.service';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('register')
  @ApiOperation({ summary: 'ユーザー登録' })
  @ApiCreatedResponse({
    description: 'The record has been successfully created.',
  })
  postRegister(@Body() body: { username: string }) {
    return this.authService.register(body.username);
  }
}
