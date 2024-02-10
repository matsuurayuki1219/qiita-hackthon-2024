import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { User } from 'src/models/user/user';
import { UserService } from 'src/services/user/user.service';

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(private userService: UserService) {}
  @Get('/')
  @ApiOperation({ summary: 'Get all users' })
  @ApiOkResponse({
    type: User,
    isArray: true,
  })
  async getUsers() {
    const users = await this.userService.getUsers();
    return users;
  }
}
