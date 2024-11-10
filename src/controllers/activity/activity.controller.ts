import { ReqHandler } from '../../types';
import { IGetActivitiesDto, IGetActivityDataDto } from './activity.dto';
import { db } from '../../db/db';
import { activityTypes, userActivityScore } from '../../db/schema';
import { StatusCodes } from 'http-status-codes';

type GetActivitiesHandler = ReqHandler<IGetActivitiesDto>;

export const getActivitiesHandler: GetActivitiesHandler = async function (
  _req,
  res
) {
  const activities = await db.select().from(activityTypes);

  res.status(StatusCodes.OK).json({
    status: 'Success',
    data: activities,
  });
};

type GetActivityDataHandler = ReqHandler<IGetActivityDataDto>;

export const getActivityHandler: GetActivitiesHandler = function (req, res) {
  // const { userId } = req.auth;
  // const { id } = req.body;
};
