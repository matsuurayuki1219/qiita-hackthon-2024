import {
  Body,
  Controller,
  Get,
  NotFoundException,
  Param,
  Post,
  Put,
  Request,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth-guard/auth-guard.guard';
import { PostPriseRequest } from 'src/request_models/post-praise-request/post-praise-request';
import { Praise } from 'src/models/praise/praise';
import { Reaction } from 'src/models/reaction/reaction';
import { PrivateRequest } from 'src/request_models/private-request/private-request';
import { PutReaction } from 'src/request_models/put-reaction/put-reaction';
import { PraiseService } from 'src/services/praise/praise.service';
import { UserService } from 'src/services/user/user.service';

@ApiBearerAuth()
@ApiTags('praise')
@UseGuards(AuthGuard)
@Controller('praise')
export class PrisesController {
  constructor(
    private priseService: PraiseService,
    private userService: UserService,
  ) {}
  @Post('/')
  @ApiCreatedResponse({
    description: 'The record has been successfully created.',
    type: Praise,
  })
  async postPraise(
    @Request() req: PrivateRequest,
    @Body() body: PostPriseRequest,
  ) {
    const from_user_id = (req.user as any).sub;
    const praise = await this.priseService.postPraise({
      title: body.title,
      description: body.description,
      from_user_id: from_user_id,
      to_user_id: body.to_user_id,
    });
    await this.userService.switchStatus(body.to_user_id);
    return praise;
  }

  @Get('/current_praise')
  @ApiOkResponse({
    description: 'The record has been successfully created.',
    type: Praise,
  })
  @ApiNotFoundResponse({
    description: 'Not found',
  })
  async currentPraise() {
    const currentPraise = await this.priseService.getCurrentPraise();
    if (currentPraise == null) {
      throw new NotFoundException();
    }
    return currentPraise;
  }

  @Put('/:praise_id/reactions')
  @ApiCreatedResponse({
    type: Reaction,
  })
  @ApiNotFoundResponse()
  async putReaction(
    @Request() req: PrivateRequest,
    @Param('praise_id') praise_id: number,
    @Body() body: PutReaction,
  ) {
    const praise = await this.priseService.findById(Number(praise_id));
    if (praise == null) {
      throw new NotFoundException();
    }
    const from_user_id = req.user.id;
    return this.priseService.putReaction(praise, {
      from_user_id: from_user_id,
      comment: body.comment,
      emoji: body.emoji,
    });
  }
}