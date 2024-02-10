import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { User } from 'src/models/user/user';

@Controller('users')
export class UsersController {
  @Get()
  @ApiOperation({ summary: 'Get all users' })
  @ApiOkResponse({
    type: User,
    isArray: true,
  })
  getUsers() {
    return [
      {
        id: 1,
        name: 'John Doe',
      },
    ];
  }
}
